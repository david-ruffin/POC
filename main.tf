resource "azurerm_resource_group" "example" {
  name     = "rg-${var.resource_group_name}-${random_string.random.result}-${var.location}"
  location = var.location
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_cognitive_account" "example" {
  name                = "ai-${var.resource_group_name}-${random_string.random.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "CognitiveServices"
  sku_name            = "S0"
  tags                = { Acceptance = "Test" }
  lifecycle {
    ignore_changes = [tags]
  }
}

output "ai_service_endpoint" {
  value = azurerm_cognitive_account.example.endpoint
}

output "ai_service_key" {
  value     = azurerm_cognitive_account.example.primary_access_key
  sensitive = true
}

resource "null_resource" "update_env" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [azurerm_cognitive_account.example]

  provisioner "local-exec" {
    command = "echo AI_SERVICE_ENDPOINT=${azurerm_cognitive_account.example.endpoint} > .env && echo AI_SERVICE_KEY=${azurerm_cognitive_account.example.primary_access_key} >> .env"
  }
}

resource "null_resource" "docker_build" {
  provisioner "local-exec" {
    command = "docker build -t open-ai-poc ."
  }
}

resource "null_resource" "docker_run" {
  depends_on = [null_resource.docker_build, null_resource.update_env]

  provisioner "local-exec" {
    command = "docker run -d -v $(pwd)/Labfiles:/usr/src/app --name my-python-app open-ai-poc"
  }
}

resource "null_resource" "docker_exec" {
  depends_on = [null_resource.docker_run]

  provisioner "local-exec" {
    command = "sh -c 'until docker exec my-python-app echo Container is up; do sleep 1; done'"
  }
}
