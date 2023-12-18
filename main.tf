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
    command = "echo AI_SERVICE_ENDPOINT=${azurerm_cognitive_account.example.endpoint} > ./Labfiles/01-analyze-images/Python/.env && echo AI_SERVICE_KEY=${azurerm_cognitive_account.example.primary_access_key} >> ./Labfiles/01-analyze-images/Python/.env"
  }
}

resource "null_resource" "docker_build" {
triggers = {
    always_run = "${timestamp()}"
  }  
provisioner "local-exec" {
    command = "sudo docker build -t open-ai-poc ."
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "random_string" {
  value = random_string.random.result
}
