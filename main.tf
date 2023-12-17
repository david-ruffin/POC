
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

  sku_name = "S0"

  tags = {
    Acceptance = "Test"
  }
  #   provisioner "local-exec" {
  #     when    = create
  #     command = var.deployment_platform_is_windows ? "powershell.exe -File update-env.ps1 ${self.endpoint} ${self.primary_access_key}" : "sh update-env.sh ${self.endpoint} ${self.primary_access_key}"
  #   }
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
    # command = "sh update-env.sh '${azurerm_cognitive_account.example.endpoint}' '${azurerm_cognitive_account.example.primary_access_key}'"
    command = "echo AI_ENDPOINT=${azurerm_cognitive_account.example.endpoint} >> .env && echo AI_KEY=${azurerm_cognitive_account.example.primary_access_key} >> .env"
  }
}

resource "null_resource" "docker_build" {
  provisioner "local-exec" {
    command = "docker build -t open-ai-poc ."
  }
}

