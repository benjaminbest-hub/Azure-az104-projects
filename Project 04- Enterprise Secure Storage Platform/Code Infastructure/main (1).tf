terraform {
  required_providers {
    azurerm = {
      source  = "azurerm"
      version = "4.80.0"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "res-0" {
  location   = "centralus"
  managed_by = ""
  name       = "rg-buystore-storage"
  tags = {
    Company            = "Buystore"
    CostCenter         = "BST-IT-001"
    DataClassification = "Confidential"
    Department         = "IT"
    Environment        = "Development"
    ManagedBy          = "Benjamin Best"
    Project            = "Enterprise-Secure-Storage"
  }
}
resource "azurerm_private_dns_zone" "res-1" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.res-0.name
  tags = {
    Company            = "Buystore"
    CostCenter         = "BST-IT-001"
    DataClassification = "Confidential"
    Department         = "IT"
    Environment        = "Development"
    ManagedBy          = "Benjamin Best"
    Project            = "Enterprise-Secure-Storage"
    Workload           = "Blob-Private-Endpoint"
  }
  soa_record {
    email        = "azureprivatedns-host.microsoft.com"
    expire_time  = 2419200
    minimum_ttl  = 10
    refresh_time = 3600
    retry_time   = 300
    tags         = {}
    ttl          = 3600
  }
}
resource "azurerm_private_dns_a_record" "res-2" {
  name                = "stbuystoredata001"
  records             = ["10.40.1.4"]
  resource_group_name = azurerm_resource_group.res-0.name
  tags = {
    creator = "created by private endpoint pep-buystore-blob with resource guid 8beed7cf-e726-45ef-be5e-049bc573e9c3"
  }
  ttl       = 10
  zone_name = "privatelink.blob.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.res-1,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-4" {
  name                  = "45tup27bntugi"
  private_dns_zone_name = "privatelink.blob.core.windows.net"
  registration_enabled  = false
  resolution_policy     = "Default"
  resource_group_name   = azurerm_resource_group.res-0.name
  tags                  = {}
  virtual_network_id    = azurerm_virtual_network.res-13.id
  depends_on = [
    azurerm_private_dns_zone.res-1,
  ]
}
resource "azurerm_private_dns_zone" "res-5" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = azurerm_resource_group.res-0.name
  tags                = {}
  soa_record {
    email        = "azureprivatedns-host.microsoft.com"
    expire_time  = 2419200
    minimum_ttl  = 10
    refresh_time = 3600
    retry_time   = 300
    tags         = {}
    ttl          = 3600
  }
}
resource "azurerm_private_dns_a_record" "res-6" {
  name                = "stbuystorefiles001"
  records             = ["10.40.1.5"]
  resource_group_name = azurerm_resource_group.res-0.name
  tags = {
    creator = "created by private endpoint pep-buystore-file with resource guid 32ef8eae-0610-45f5-844c-ceb1a125014f"
  }
  ttl       = 10
  zone_name = "privatelink.file.core.windows.net"
  depends_on = [
    azurerm_private_dns_zone.res-5,
  ]
}
resource "azurerm_private_dns_zone_virtual_network_link" "res-8" {
  name                  = "45tup27bntugi"
  private_dns_zone_name = "privatelink.file.core.windows.net"
  registration_enabled  = false
  resolution_policy     = "Default"
  resource_group_name   = azurerm_resource_group.res-0.name
  tags                  = {}
  virtual_network_id    = azurerm_virtual_network.res-13.id
  depends_on = [
    azurerm_private_dns_zone.res-5,
  ]
}
resource "azurerm_private_endpoint" "res-9" {
  custom_network_interface_name = "nic-pep-buystore-blob"
  location                      = "centralus"
  name                          = "pep-buystore-blob"
  resource_group_name           = azurerm_resource_group.res-0.name
  subnet_id                     = azurerm_subnet.res-15.id
  tags = {
    Company            = "Buystore"
    CostCenter         = "BST-IT-001"
    DataClassification = "Confidential"
    Department         = "IT"
    Environment        = "Development"
    ManagedBy          = "Benjamin Best"
    Project            = "Enterprise-Secure-Storage"
    Workload           = "Blob-Private-Endpoint"
  }
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.res-1.id]
  }
  private_service_connection {
    is_manual_connection              = false
    name                              = "pep-buystore-blob"
    private_connection_resource_alias = ""
    private_connection_resource_id    = azurerm_storage_account.res-23.id
    request_message                   = ""
    subresource_names                 = ["blob"]
  }
}
resource "azurerm_private_endpoint" "res-11" {
  custom_network_interface_name = "nic-pep-buystore-file"
  location                      = "centralus"
  name                          = "pep-buystore-file"
  resource_group_name           = azurerm_resource_group.res-0.name
  subnet_id                     = azurerm_subnet.res-15.id
  tags                          = {}
  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.res-5.id]
  }
  private_service_connection {
    is_manual_connection              = false
    name                              = "pep-buystore-file"
    private_connection_resource_alias = ""
    private_connection_resource_id    = azurerm_storage_account.res-35.id
    request_message                   = ""
    subresource_names                 = ["file"]
  }
}
resource "azurerm_virtual_network" "res-13" {
  address_space                  = ["10.40.0.0/16"]
  bgp_community                  = ""
  dns_servers                    = []
  edge_zone                      = ""
  flow_timeout_in_minutes        = 0
  location                       = "centralus"
  name                           = "vnet-buystore-storage"
  private_endpoint_vnet_policies = "Disabled"
  resource_group_name            = azurerm_resource_group.res-0.name
  subnet = [{
    address_prefixes                              = ["10.40.1.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/11eeac9e-0c54-44f5-9f59-a163f792c6e3/resourceGroups/rg-buystore-storage/providers/Microsoft.Network/virtualNetworks/vnet-buystore-storage/subnets/snet-private-endpoints"
    name                                          = "snet-private-endpoints"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
    }, {
    address_prefixes                              = ["10.40.2.0/24"]
    default_outbound_access_enabled               = false
    delegation                                    = []
    id                                            = "/subscriptions/11eeac9e-0c54-44f5-9f59-a163f792c6e3/resourceGroups/rg-buystore-storage/providers/Microsoft.Network/virtualNetworks/vnet-buystore-storage/subnets/snet-management"
    name                                          = "snet-management"
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    route_table_id                                = ""
    security_group                                = ""
    service_endpoint_policy_ids                   = []
    service_endpoints                             = []
  }]
  tags = {}
}
resource "azurerm_subnet" "res-14" {
  address_prefixes                              = ["10.40.2.0/24"]
  default_outbound_access_enabled               = false
  name                                          = "snet-management"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "vnet-buystore-storage"
  depends_on = [
    azurerm_virtual_network.res-13,
  ]
}
resource "azurerm_subnet" "res-15" {
  address_prefixes                              = ["10.40.1.0/24"]
  default_outbound_access_enabled               = false
  name                                          = "snet-private-endpoints"
  private_endpoint_network_policies             = "Disabled"
  private_link_service_network_policies_enabled = true
  resource_group_name                           = azurerm_resource_group.res-0.name
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
  sharing_scope                                 = ""
  virtual_network_name                          = "vnet-buystore-storage"
  depends_on = [
    azurerm_virtual_network.res-13,
  ]
}
resource "azurerm_recovery_services_vault" "res-16" {
  classic_vmware_replication_enabled = false
  cross_region_restore_enabled       = false
  immutability                       = "Disabled"
  location                           = "centralus"
  name                               = "vault-mryrxs7i"
  public_network_access_enabled      = true
  resource_group_name                = azurerm_resource_group.res-0.name
  sku                                = "RS0"
  soft_delete_enabled                = true
  storage_mode_type                  = "GeoRedundant"
  tags                               = {}
}
resource "azurerm_backup_policy_file_share" "res-17" {
  backup_tier                = "snapshot"
  name                       = "DailyPolicy-mryrxsnq"
  recovery_vault_name        = "vault-mryrxs7i"
  resource_group_name        = azurerm_resource_group.res-0.name
  snapshot_retention_in_days = 0
  timezone                   = "UTC"
  backup {
    frequency = "Daily"
    time      = "19:30"
  }
  retention_daily {
    count = 30
  }
  depends_on = [
    azurerm_recovery_services_vault.res-16,
  ]
}
resource "azurerm_backup_policy_vm" "res-18" {
  consistency_type               = ""
  instant_restore_retention_days = 2
  name                           = "DefaultPolicy"
  policy_type                    = "V1"
  recovery_vault_name            = "vault-mryrxs7i"
  resource_group_name            = azurerm_resource_group.res-0.name
  timezone                       = "UTC"
  backup {
    frequency     = "Daily"
    hour_duration = 0
    hour_interval = 0
    time          = "20:00"
    weekdays      = []
  }
  retention_daily {
    count = 30
  }
  depends_on = [
    azurerm_recovery_services_vault.res-16,
  ]
}
resource "azurerm_backup_policy_vm" "res-19" {
  consistency_type               = ""
  instant_restore_retention_days = 2
  name                           = "EnhancedPolicy"
  policy_type                    = "V2"
  recovery_vault_name            = "vault-mryrxs7i"
  resource_group_name            = azurerm_resource_group.res-0.name
  timezone                       = "UTC"
  backup {
    frequency     = "Hourly"
    hour_duration = 12
    hour_interval = 4
    time          = "08:00"
    weekdays      = []
  }
  retention_daily {
    count = 30
  }
  depends_on = [
    azurerm_recovery_services_vault.res-16,
  ]
}
resource "azurerm_backup_policy_vm_workload" "res-20" {
  name                = "HourlyLogBackup"
  recovery_vault_name = "vault-mryrxs7i"
  resource_group_name = azurerm_resource_group.res-0.name
  workload_type       = "SQLDataBase"
  protection_policy {
    policy_type = "Log"
    backup {
      frequency            = ""
      frequency_in_minutes = 60
      time                 = ""
      weekdays             = []
    }
    simple_retention {
      count = 30
    }
  }
  protection_policy {
    policy_type = "Full"
    backup {
      frequency            = "Daily"
      frequency_in_minutes = 0
      time                 = "20:00"
      weekdays             = []
    }
    retention_daily {
      count = 30
    }
  }
  settings {
    compression_enabled = false
    time_zone           = "UTC"
  }
  depends_on = [
    azurerm_recovery_services_vault.res-16,
  ]
}
resource "azurerm_storage_account" "res-23" {
  access_tier                       = "Hot"
  account_kind                      = "StorageV2"
  account_replication_type          = "GRS"
  account_tier                      = "Standard"
  allow_nested_items_to_be_public   = false
  allowed_copy_scope                = ""
  cross_tenant_replication_enabled  = false
  default_to_oauth_authentication   = false
  dns_endpoint_type                 = "Standard"
  edge_zone                         = ""
  https_traffic_only_enabled        = true
  infrastructure_encryption_enabled = false
  is_hns_enabled                    = false
  large_file_share_enabled          = false
  local_user_enabled                = true
  location                          = "centralus"
  min_tls_version                   = "TLS1_2"
  name                              = "stbuystoredata001"
  nfsv3_enabled                     = false
  provisioned_billing_model_version = ""
  public_network_access_enabled     = false
  queue_encryption_key_type         = "Service"
  resource_group_name               = azurerm_resource_group.res-0.name
  sftp_enabled                      = false
  shared_access_key_enabled         = true
  table_encryption_key_type         = "Service"
  tags = {
    Company            = "Buystore"
    CostCenter         = "BST-IT-001"
    DataClassification = "Confidential"
    Department         = "IT"
    Environment        = "Development"
    ManagedBy          = "Benjamin Best"
    Workload           = "Blob-DATA"
  }
  blob_properties {
    change_feed_enabled           = false
    change_feed_retention_in_days = 0
    default_service_version       = ""
    last_access_time_enabled      = false
    versioning_enabled            = true
    container_delete_retention_policy {
      days = 14
    }
    delete_retention_policy {
      days                     = 14
      permanent_delete_enabled = false
    }
  }
  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  share_properties {
    retention_policy {
      days = 7
    }
  }
}
resource "azurerm_storage_container" "res-25" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "application-backups"
  storage_account_id                = azurerm_storage_account.res-23.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-26" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "company-documents"
  storage_account_id                = azurerm_storage_account.res-23.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-27" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "finance-documents"
  storage_account_id                = azurerm_storage_account.res-23.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-28" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "hr-records"
  storage_account_id                = azurerm_storage_account.res-23.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-29" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "marketing-assets"
  storage_account_id                = azurerm_storage_account.res-23.id
  storage_account_name              = ""
}
resource "azurerm_storage_container" "res-30" {
  container_access_type             = "private"
  default_encryption_scope          = "$account-encryption-key"
  encryption_scope_override_enabled = true
  metadata                          = {}
  name                              = "product-images"
  storage_account_id                = azurerm_storage_account.res-23.id
  storage_account_name              = ""
}
resource "azurerm_storage_account" "res-35" {
  access_tier                       = ""
  account_kind                      = "FileStorage"
  account_replication_type          = "GRS"
  account_tier                      = "Standard"
  allow_nested_items_to_be_public   = false
  allowed_copy_scope                = ""
  cross_tenant_replication_enabled  = false
  default_to_oauth_authentication   = false
  dns_endpoint_type                 = "Standard"
  edge_zone                         = ""
  https_traffic_only_enabled        = true
  infrastructure_encryption_enabled = false
  is_hns_enabled                    = false
  large_file_share_enabled          = true
  local_user_enabled                = true
  location                          = "centralus"
  min_tls_version                   = "TLS1_2"
  name                              = "stbuystorefiles001"
  nfsv3_enabled                     = false
  provisioned_billing_model_version = "V2"
  public_network_access_enabled     = false
  queue_encryption_key_type         = "Service"
  resource_group_name               = azurerm_resource_group.res-0.name
  sftp_enabled                      = false
  shared_access_key_enabled         = true
  table_encryption_key_type         = "Service"
  tags = {
    Company            = "Buystore"
    CostCenter         = "BST-IT-001"
    DataClassification = "Confidential"
    Department         = "IT"
    Environment        = "Development"
    ManagedBy          = "Benjamin Best"
    Project            = "Enterprise-Secure-Storage"
    Workload           = "AzureFileShare"
  }
  network_rules {
    bypass                     = ["AzureServices"]
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  share_properties {
    retention_policy {
      days = 14
    }
    smb {
      authentication_types            = []
      channel_encryption_type         = []
      kerberos_ticket_encryption_type = []
      multichannel_enabled            = false
      versions                        = []
    }
  }
}
resource "azurerm_storage_share" "res-37" {
  access_tier      = ""
  enabled_protocol = "SMB"
  metadata = {
    AzureBackupProtected = "true"
  }
  name                 = "finance-files"
  quota                = 5120
  storage_account_id   = azurerm_storage_account.res-35.id
  storage_account_name = ""
}
resource "azurerm_storage_share" "res-38" {
  access_tier          = ""
  enabled_protocol     = "SMB"
  metadata             = {}
  name                 = "hr-files"
  quota                = 5120
  storage_account_id   = azurerm_storage_account.res-35.id
  storage_account_name = ""
}
resource "azurerm_storage_share" "res-39" {
  access_tier      = ""
  enabled_protocol = "SMB"
  metadata = {
    AzureBackupProtected = "true"
  }
  name                 = "it-files"
  quota                = 5120
  storage_account_id   = azurerm_storage_account.res-35.id
  storage_account_name = ""
}
resource "azurerm_storage_share" "res-40" {
  access_tier          = ""
  enabled_protocol     = "SMB"
  metadata             = {}
  name                 = "marketing-files"
  quota                = 5120
  storage_account_id   = azurerm_storage_account.res-35.id
  storage_account_name = ""
}
resource "azurerm_storage_share" "res-41" {
  access_tier      = ""
  enabled_protocol = "SMB"
  metadata = {
    AzureBackupProtected = "true"
  }
  name                 = "operations-files"
  quota                = 5120
  storage_account_id   = azurerm_storage_account.res-35.id
  storage_account_name = ""
}
