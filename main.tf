resource "azurerm_resource_group" "example" {
  name     = "rg-${var.resource_group_name}-${random_string.random.result}-${var.location}"
  location = var.location
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_cognitive_account" "example" {
  name                                         = "ai-${var.resource_group_name}-${random_string.random.result}"
  location                                     = azurerm_resource_group.example.location
  resource_group_name                          = azurerm_resource_group.example.name
  custom_subdomain_name                        = "ai-${var.resource_group_name}-${random_string.random.result}"
  kind                                         = "CognitiveServices"
  dynamic_throttling_enabled                   = false
  local_auth_enabled                           = true
  sku_name                                     = "S0"
  outbound_network_access_restricted           = false
  public_network_access_enabled                = true
  custom_question_answering_search_service_id  = null
  custom_question_answering_search_service_key = null # sensitive
  metrics_advisor_aad_client_id                = null
  metrics_advisor_aad_tenant_id                = null
  metrics_advisor_super_user_name              = null
  metrics_advisor_website_name                 = null
  qna_runtime_endpoint                         = null
  tags                                         = { Acceptance = "Test" }
  network_acls {
    default_action = "Allow"
    ip_rules       = []
  }
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

locals {
  ai_service_endpoint = azurerm_cognitive_account.example.endpoint
}

resource "null_resource" "update_env" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [azurerm_cognitive_account.example]

  provisioner "local-exec" {
    command = "echo AI_SERVICE_ENDPOINT=${local.ai_service_endpoint} > ./Labfiles/01-analyze-images/Python/image-analysis/.env && echo AI_SERVICE_KEY=${azurerm_cognitive_account.example.primary_access_key} >> ./Labfiles/01-analyze-images/Python/image-analysis/.env"
  }
}

resource "null_resource" "docker_build" {
triggers = {
    always_run = "${timestamp()}"
  }  
provisioner "local-exec" {
    command = "docker build -t open-ai-poc ."
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.example.name
}

output "random_string" {
  value = random_string.random.result
}
