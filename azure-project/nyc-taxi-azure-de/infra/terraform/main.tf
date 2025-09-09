terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.40.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "res-0" {
  location   = "eastus2"
  managed_by = ""
  name       = "rg-portfolio"
  tags       = {}
}
resource "azurerm_data_factory" "res-1" {
  customer_managed_key_id          = ""
  customer_managed_key_identity_id = ""
  location                         = "eastus"
  managed_virtual_network_enabled  = false
  name                             = "adf-portfolio"
  public_network_enabled           = true
  purview_id                       = ""
  resource_group_name              = azurerm_resource_group.res-0.name
  tags                             = {}
  github_configuration {
    account_name       = "williamnsambu"
    branch_name        = "main"
    git_url            = "https://github.com"
    publishing_enabled = true
    repository_name    = "modern-data-stack-lab"
    root_folder        = "/azure-project/nyc-taxi-azure-de/adf/"
  }
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
}
resource "azurerm_databricks_access_connector" "res-2" {
  location            = "eastus"
  name                = "adb-access-connector"
  resource_group_name = azurerm_resource_group.res-0.name
  tags                = {}
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
}
resource "azurerm_databricks_workspace" "res-3" {
  customer_managed_key_enabled                        = false
  infrastructure_encryption_enabled                   = false
  load_balancer_backend_address_pool_id               = ""
  location                                            = "eastus2"
  managed_disk_cmk_key_vault_id                       = ""
  managed_disk_cmk_key_vault_key_id                   = ""
  managed_disk_cmk_rotation_to_latest_version_enabled = false
  managed_resource_group_name                         = "databricks-rg-adb-portfolio-askzlu34ux7jq"
  managed_services_cmk_key_vault_id                   = ""
  managed_services_cmk_key_vault_key_id               = ""
  name                                                = "adb-portfolio"
  resource_group_name                                 = azurerm_resource_group.res-0.name
  sku                                                 = "standard"
  tags                                                = {}
  custom_parameters {
    machine_learning_workspace_id                        = ""
    nat_gateway_name                                     = ""
    no_public_ip                                         = true
    private_subnet_name                                  = ""
    private_subnet_network_security_group_association_id = ""
    public_ip_name                                       = ""
    public_subnet_name                                   = ""
    public_subnet_network_security_group_association_id  = ""
    storage_account_name                                 = "dbstorageskr3knae2vwac"
    storage_account_sku_name                             = "Standard_GRS"
    virtual_network_id                                   = ""
    vnet_address_prefix                                  = ""
  }
}
resource "azurerm_eventhub_namespace" "res-4" {
  auto_inflate_enabled                      = false
  capacity                                  = 1
  dedicated_cluster_id                      = ""
  default_primary_connection_string         = "" # Masked sensitive attribute
  default_primary_connection_string_alias   = "" # Masked sensitive attribute
  default_primary_key                       = "" # Masked sensitive attribute
  default_secondary_connection_string       = "" # Masked sensitive attribute
  default_secondary_connection_string_alias = "" # Masked sensitive attribute
  default_secondary_key                     = "" # Masked sensitive attribute
  local_authentication_enabled              = true
  location                                  = "eastus2"
  maximum_throughput_units                  = 0
  minimum_tls_version                       = "1.2"
  name                                      = "eh-portfolio"
  network_rulesets = [{
    default_action                 = "Allow"
    ip_rule                        = []
    public_network_access_enabled  = true
    trusted_service_access_enabled = false
    virtual_network_rule           = []
  }]
  public_network_access_enabled = true
  resource_group_name           = azurerm_resource_group.res-0.name
  sku                           = "Basic"
  tags                          = {}
}
resource "azurerm_eventhub_namespace_authorization_rule" "res-5" {
  listen                            = true
  manage                            = true
  name                              = "RootManageSharedAccessKey"
  namespace_name                    = "eh-portfolio"
  primary_connection_string         = "" # Masked sensitive attribute
  primary_connection_string_alias   = "" # Masked sensitive attribute
  primary_key                       = "" # Masked sensitive attribute
  resource_group_name               = azurerm_resource_group.res-0.name
  secondary_connection_string       = "" # Masked sensitive attribute
  secondary_connection_string_alias = "" # Masked sensitive attribute
  secondary_key                     = "" # Masked sensitive attribute
  send                              = true
  depends_on = [
    azurerm_eventhub_namespace.res-4,
  ]
}
resource "azurerm_key_vault" "res-7" {
  access_policy                   = []
  enable_rbac_authorization       = true
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
  location                        = "eastus"
  name                            = "akv-portfolio"
  public_network_access_enabled   = true
  purge_protection_enabled        = false
  resource_group_name             = azurerm_resource_group.res-0.name
  sku_name                        = "standard"
  soft_delete_retention_days      = 90
  tags                            = {}
  tenant_id                       = "2ba9001d-d7f9-43a3-a098-6a927ac715ca"
  network_acls {
    bypass                     = "None"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
}
resource "azurerm_storage_account" "res-12" {
  access_tier                       = "Hot"
  account_kind                      = "StorageV2"
  account_replication_type          = "RAGRS"
  account_tier                      = "Standard"
  allow_nested_items_to_be_public   = false
  allowed_copy_scope                = ""
  cross_tenant_replication_enabled  = false
  default_to_oauth_authentication   = false
  dns_endpoint_type                 = "Standard"
  edge_zone                         = ""
  https_traffic_only_enabled        = true
  infrastructure_encryption_enabled = false
  is_hns_enabled                    = true
  large_file_share_enabled          = true
  local_user_enabled                = true
  location                          = "eastus2"
  min_tls_version                   = "TLS1_2"
  name                              = "assportfolio"
  nfsv3_enabled                     = false
  primary_access_key                = "" # Masked sensitive attribute
  primary_blob_connection_string    = "" # Masked sensitive attribute
  primary_connection_string         = "" # Masked sensitive attribute
  provisioned_billing_model_version = ""
  public_network_access_enabled     = true
  queue_encryption_key_type         = "Service"
  resource_group_name               = azurerm_resource_group.res-0.name
  secondary_access_key              = "" # Masked sensitive attribute
  secondary_blob_connection_string  = "" # Masked sensitive attribute
  secondary_connection_string       = "" # Masked sensitive attribute
  sftp_enabled                      = false
  shared_access_key_enabled         = true
  table_encryption_key_type         = "Service"
  tags                              = {}
  blob_properties {
    change_feed_enabled           = false
    change_feed_retention_in_days = 0
    default_service_version       = ""
    last_access_time_enabled      = false
    versioning_enabled            = false
    container_delete_retention_policy {
      days = 7
    }
    delete_retention_policy {
      days                     = 7
      permanent_delete_enabled = false
    }
  }
  share_properties {
    retention_policy {
      days = 7
    }
  }
}
resource "azurerm_storage_container" "res-14" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "asafilesystemportfolio"
  storage_account_id                = azurerm_storage_account.res-12.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-15" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "bronze"
  storage_account_id                = azurerm_storage_account.res-12.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-16" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "checkpoints"
  storage_account_id                = azurerm_storage_account.res-12.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-17" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "gold"
  storage_account_id                = azurerm_storage_account.res-12.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-18" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "landing"
  storage_account_id                = azurerm_storage_account.res-12.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-19" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "silver"
  storage_account_id                = azurerm_storage_account.res-12.id
  storage_account_name              = ""
}
resource "azurerm_synapse_workspace" "res-23" {
  azuread_authentication_only          = false
  location                             = "eastus2"
  managed_resource_group_name          = "synapseworkspace-managedrg-2d203f7f-7c58-4c4e-9b78-0076ef9e6b56"
  managed_virtual_network_enabled      = false
  name                                 = "asa-portfolio"
  public_network_access_enabled        = true
  resource_group_name                  = azurerm_resource_group.res-0.name
  sql_administrator_login              = "sqladminuser"
  sql_administrator_login_password     = "" # Masked sensitive attribute
  sql_identity_control_enabled         = false
  storage_data_lake_gen2_filesystem_id = "https://assportfolio.dfs.core.windows.net/asafilesystemportfolio"
  tags                                 = {}
  github_repo {
    account_name    = "williamnsambu"
    branch_name     = "main"
    git_url         = "https://github.com"
    last_commit_id  = "96a0e14cf489adb87f2d86a86d862e8a23a28c45"
    repository_name = "modern-data-stack-lab"
    root_folder     = "/azure-project/nyc-taxi-azure-de/synapse/"
  }
  identity {
    identity_ids = []
    type         = "SystemAssigned"
  }
}
resource "azurerm_synapse_spark_pool" "res-26" {
  cache_size                          = 50
  compute_isolation_enabled           = false
  dynamic_executor_allocation_enabled = true
  max_executors                       = 4
  min_executors                       = 1
  name                                = "aspportfolio"
  node_count                          = 10
  node_size                           = "Small"
  node_size_family                    = "MemoryOptimized"
  session_level_packages_enabled      = false
  spark_version                       = "3.5"
  synapse_workspace_id                = azurerm_synapse_workspace.res-23.id
  tags                                = {}
  auto_pause {
    delay_in_minutes = 15
  }
  auto_scale {
    max_node_count = 12
    min_node_count = 3
  }
}
resource "azurerm_synapse_workspace_extended_auditing_policy" "res-28" {
  log_monitoring_enabled                  = false
  retention_in_days                       = 0
  storage_account_access_key              = "" # Masked sensitive attribute
  storage_account_access_key_is_secondary = false
  storage_endpoint                        = ""
  synapse_workspace_id                    = azurerm_synapse_workspace.res-23.id
}
resource "azurerm_synapse_firewall_rule" "res-29" {
  end_ip_address       = "255.255.255.255"
  name                 = "allowAll"
  start_ip_address     = "0.0.0.0"
  synapse_workspace_id = azurerm_synapse_workspace.res-23.id
}
resource "azurerm_synapse_integration_runtime_azure" "res-30" {
  description          = ""
  location             = "AutoResolve"
  name                 = "AutoResolveIntegrationRuntime"
  synapse_workspace_id = azurerm_synapse_workspace.res-23.id
}
resource "azurerm_synapse_workspace_security_alert_policy" "res-31" {
  disabled_alerts              = []
  email_account_admins_enabled = false
  email_addresses              = []
  policy_state                 = "Disabled"
  retention_days               = 0
  storage_account_access_key   = "" # Masked sensitive attribute
  storage_endpoint             = ""
  synapse_workspace_id         = azurerm_synapse_workspace.res-23.id
}
resource "azurerm_synapse_workspace_vulnerability_assessment" "res-32" {
  storage_account_access_key         = "" # Masked sensitive attribute
  storage_container_path             = ""
  storage_container_sas_key          = "" # Masked sensitive attribute
  workspace_security_alert_policy_id = azurerm_synapse_workspace_security_alert_policy.res-31.id
  recurring_scans {
    email_subscription_admins_enabled = true
    emails                            = []
    enabled                           = false
  }
}
