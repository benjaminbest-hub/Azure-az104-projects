param vaults_vault_mryrxs7i_name string = 'vault-mryrxs7i'
param storageAccounts_stbuystoredata001_name string = 'stbuystoredata001'
param privateEndpoints_pep_buystore_blob_name string = 'pep-buystore-blob'
param privateEndpoints_pep_buystore_file_name string = 'pep-buystore-file'
param storageAccounts_stbuystorefiles001_name string = 'stbuystorefiles001'
param virtualNetworks_vnet_buystore_storage_name string = 'vnet-buystore-storage'
param privateDnsZones_privatelink_blob_core_windows_net_name string = 'privatelink.blob.core.windows.net'
param privateDnsZones_privatelink_file_core_windows_net_name string = 'privatelink.file.core.windows.net'

resource privateDnsZones_privatelink_blob_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_blob_core_windows_net_name
  location: 'global'
  tags: {
    Company: 'Buystore'
    CostCenter: 'BST-IT-001'
    DataClassification: 'Confidential'
    Department: 'IT'
    Environment: 'Development'
    ManagedBy: 'Benjamin Best'
    Project: 'Enterprise-Secure-Storage'
    Workload: 'Blob-Private-Endpoint'
  }
  properties: {}
}

resource privateDnsZones_privatelink_file_core_windows_net_name_resource 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateDnsZones_privatelink_file_core_windows_net_name
  location: 'global'
  properties: {}
}

resource virtualNetworks_vnet_buystore_storage_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vnet_buystore_storage_name
  location: 'centralus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.40.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'snet-private-endpoints'
        id: virtualNetworks_vnet_buystore_storage_name_snet_private_endpoints.id
        properties: {
          addressPrefixes: [
            '10.40.1.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'snet-management'
        id: virtualNetworks_vnet_buystore_storage_name_snet_management.id
        properties: {
          addressPrefixes: [
            '10.40.2.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vaults_vault_mryrxs7i_name_resource 'Microsoft.RecoveryServices/vaults@2026-02-01' = {
  name: vaults_vault_mryrxs7i_name
  location: 'centralus'
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    securitySettings: {
      softDeleteSettings: {
        softDeleteRetentionPeriodInDays: 14
        softDeleteState: 'Enabled'
        enhancedSecurityState: 'Enabled'
      }
      sourceScanConfiguration: {
        state: 'Disabled'
      }
    }
    redundancySettings: {
      standardTierStorageRedundancy: 'GeoRedundant'
      crossRegionRestore: 'Disabled'
    }
    publicNetworkAccess: 'Enabled'
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
  }
}

resource storageAccounts_stbuystoredata001_name_resource 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: storageAccounts_stbuystoredata001_name
  location: 'centralus'
  tags: {
    Company: 'Buystore'
    Environment: 'Development'
    Department: 'IT'
    ManagedBy: 'Benjamin Best'
    CostCenter: 'BST-IT-001'
    DataClassification: 'Confidential'
    Workload: 'Blob-DATA'
  }
  sku: {
    name: 'Standard_GRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dualStackEndpointPreference: {
      publishIpv6Endpoint: false
    }
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      ipv6Rules: []
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_stbuystorefiles001_name_resource 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: storageAccounts_stbuystorefiles001_name
  location: 'centralus'
  tags: {
    Company: 'Buystore'
    CostCenter: 'BST-IT-001'
    DataClassification: 'Confidential'
    Department: 'IT'
    Environment: 'Development'
    ManagedBy: 'Benjamin Best'
    Project: 'Enterprise-Secure-Storage'
    Workload: 'AzureFileShare'
  }
  sku: {
    name: 'StandardV2_GRS'
    tier: 'Standard'
  }
  kind: 'FileStorage'
  properties: {
    dualStackEndpointPreference: {
      publishIpv6Endpoint: false
    }
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Disabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      ipv6Rules: []
      resourceAccessRules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Deny'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_stbuystoredata001 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: 'stbuystoredata001'
  properties: {
    metadata: {
      creator: 'created by private endpoint pep-buystore-blob with resource guid 8beed7cf-e726-45ef-be5e-049bc573e9c3'
    }
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.40.1.4'
      }
    ]
  }
}

resource privateDnsZones_privatelink_file_core_windows_net_name_stbuystorefiles001 'Microsoft.Network/privateDnsZones/A@2024-06-01' = {
  parent: privateDnsZones_privatelink_file_core_windows_net_name_resource
  name: 'stbuystorefiles001'
  properties: {
    metadata: {
      creator: 'created by private endpoint pep-buystore-file with resource guid 32ef8eae-0610-45f5-844c-ceb1a125014f'
    }
    ttl: 10
    aRecords: [
      {
        ipv4Address: '10.40.1.5'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_blob_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_privatelink_file_core_windows_net_name 'Microsoft.Network/privateDnsZones/SOA@2024-06-01' = {
  parent: privateDnsZones_privatelink_file_core_windows_net_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_vnet_buystore_storage_name_snet_management 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_buystore_storage_name}/snet-management'
  properties: {
    addressPrefixes: [
      '10.40.2.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_buystore_storage_name_resource
  ]
}

resource virtualNetworks_vnet_buystore_storage_name_snet_private_endpoints 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_buystore_storage_name}/snet-private-endpoints'
  properties: {
    addressPrefixes: [
      '10.40.1.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_buystore_storage_name_resource
  ]
}

resource vaults_vault_mryrxs7i_name_DailyPolicy_mryrxsnq 'Microsoft.RecoveryServices/vaults/backupPolicies@2026-02-01' = {
  parent: vaults_vault_mryrxs7i_name_resource
  name: 'DailyPolicy-mryrxsnq'
  properties: {
    backupManagementType: 'AzureStorage'
    workLoadType: 'AzureFileShare'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-07-24T19:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-07-24T19:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_mryrxs7i_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2026-02-01' = {
  parent: vaults_vault_mryrxs7i_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V1'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2026-07-24T20:00:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-07-24T20:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_mryrxs7i_name_EnhancedPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2026-02-01' = {
  parent: vaults_vault_mryrxs7i_name_resource
  name: 'EnhancedPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2026-07-24T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2026-07-24T08:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_vault_mryrxs7i_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2026-02-01' = {
  parent: vaults_vault_mryrxs7i_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2026-07-24T20:00:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2026-07-24T20:00:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_vault_mryrxs7i_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2026-02-01' = {
  parent: vaults_vault_mryrxs7i_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_vault_mryrxs7i_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2026-02-01' = {
  parent: vaults_vault_mryrxs7i_name_resource
  name: 'default'
  properties: {}
}

resource storageAccounts_stbuystoredata001_name_default 'Microsoft.Storage/storageAccounts/blobServices@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_resource
  name: 'default'
  sku: {
    name: 'Standard_GRS'
    tier: 'Standard'
  }
  properties: {
    staticWebsite: {
      enabled: false
    }
    changeFeed: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 14
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 14
    }
    isVersioningEnabled: true
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_stbuystoredata001_name_default 'Microsoft.Storage/storageAccounts/fileServices@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_resource
  name: 'default'
  sku: {
    name: 'Standard_GRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
        encryptionInTransit: {
          required: true
        }
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource storageAccounts_stbuystorefiles001_name_default 'Microsoft.Storage/storageAccounts/fileServices@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_resource
  name: 'default'
  sku: {
    name: 'StandardV2_GRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
        encryptionInTransit: {
          required: true
        }
        multichannel: {
          enabled: false
        }
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 14
    }
  }
}

resource storageAccounts_stbuystoredata001_name_storageAccounts_stbuystoredata001_name_72cff8f8_cf5d_45c3_89f9_a03e1b9f16f7 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_resource
  name: '${storageAccounts_stbuystoredata001_name}.72cff8f8-cf5d-45c3-89f9-a03e1b9f16f7'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource storageAccounts_stbuystorefiles001_name_storageAccounts_stbuystorefiles001_name_503d09b4_ffd7_4261_ad7f_e951da5e8297 'Microsoft.Storage/storageAccounts/privateEndpointConnections@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_resource
  name: '${storageAccounts_stbuystorefiles001_name}.503d09b4-ffd7-4261-ad7f-e951da5e8297'
  properties: {
    privateEndpoint: {}
    privateLinkServiceConnectionState: {
      status: 'Approved'
      description: 'Auto-Approved'
      actionRequired: 'None'
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_stbuystoredata001_name_default 'Microsoft.Storage/storageAccounts/queueServices@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_stbuystoredata001_name_default 'Microsoft.Storage/storageAccounts/tableServices@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource privateDnsZones_privatelink_blob_core_windows_net_name_45tup27bntugi 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_blob_core_windows_net_name_resource
  name: '45tup27bntugi'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_vnet_buystore_storage_name_resource.id
    }
  }
}

resource privateDnsZones_privatelink_file_core_windows_net_name_45tup27bntugi 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: privateDnsZones_privatelink_file_core_windows_net_name_resource
  name: '45tup27bntugi'
  location: 'global'
  properties: {
    registrationEnabled: false
    resolutionPolicy: 'Default'
    virtualNetwork: {
      id: virtualNetworks_vnet_buystore_storage_name_resource.id
    }
  }
}

resource privateEndpoints_pep_buystore_blob_name_resource 'Microsoft.Network/privateEndpoints@2025-07-01' = {
  name: privateEndpoints_pep_buystore_blob_name
  location: 'centralus'
  tags: {
    Company: 'Buystore'
    CostCenter: 'BST-IT-001'
    DataClassification: 'Confidential'
    Department: 'IT'
    Environment: 'Development'
    ManagedBy: 'Benjamin Best'
    Project: 'Enterprise-Secure-Storage'
    Workload: 'Blob-Private-Endpoint'
  }
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_pep_buystore_blob_name
        id: '${privateEndpoints_pep_buystore_blob_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_pep_buystore_blob_name}'
        properties: {
          privateLinkServiceId: storageAccounts_stbuystoredata001_name_resource.id
          groupIds: [
            'blob'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: 'nic-${privateEndpoints_pep_buystore_blob_name}'
    subnet: {
      id: virtualNetworks_vnet_buystore_storage_name_snet_private_endpoints.id
    }
    ipConfigurations: []
    customDnsConfigs: []
    ipVersionType: 'IPv4'
  }
}

resource privateEndpoints_pep_buystore_file_name_resource 'Microsoft.Network/privateEndpoints@2025-07-01' = {
  name: privateEndpoints_pep_buystore_file_name
  location: 'centralus'
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateEndpoints_pep_buystore_file_name
        id: '${privateEndpoints_pep_buystore_file_name_resource.id}/privateLinkServiceConnections/${privateEndpoints_pep_buystore_file_name}'
        properties: {
          privateLinkServiceId: storageAccounts_stbuystorefiles001_name_resource.id
          groupIds: [
            'file'
          ]
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    manualPrivateLinkServiceConnections: []
    customNetworkInterfaceName: 'nic-${privateEndpoints_pep_buystore_file_name}'
    subnet: {
      id: virtualNetworks_vnet_buystore_storage_name_snet_private_endpoints.id
    }
    ipConfigurations: []
    customDnsConfigs: []
    ipVersionType: 'IPv4'
  }
}

resource privateEndpoints_pep_buystore_blob_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2025-07-01' = {
  name: '${privateEndpoints_pep_buystore_blob_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-blob-core-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_blob_core_windows_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_pep_buystore_blob_name_resource
  ]
}

resource privateEndpoints_pep_buystore_file_name_default 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2025-07-01' = {
  name: '${privateEndpoints_pep_buystore_file_name}/default'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink-file-core-windows-net'
        properties: {
          privateDnsZoneId: privateDnsZones_privatelink_file_core_windows_net_name_resource.id
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoints_pep_buystore_file_name_resource
  ]
}

resource storageAccounts_stbuystoredata001_name_default_application_backups 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_default
  name: 'application-backups'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stbuystoredata001_name_resource
  ]
}

resource storageAccounts_stbuystoredata001_name_default_company_documents 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_default
  name: 'company-documents'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stbuystoredata001_name_resource
  ]
}

resource storageAccounts_stbuystoredata001_name_default_finance_documents 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_default
  name: 'finance-documents'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stbuystoredata001_name_resource
  ]
}

resource storageAccounts_stbuystoredata001_name_default_hr_records 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_default
  name: 'hr-records'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stbuystoredata001_name_resource
  ]
}

resource storageAccounts_stbuystoredata001_name_default_marketing_assets 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_default
  name: 'marketing-assets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stbuystoredata001_name_resource
  ]
}

resource storageAccounts_stbuystoredata001_name_default_product_images 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_stbuystoredata001_name_default
  name: 'product-images'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_stbuystoredata001_name_resource
  ]
}

resource storageAccounts_stbuystorefiles001_name_default_finance_files 'Microsoft.Storage/storageAccounts/fileServices/shares@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_default
  name: 'finance-files'
  properties: {
    provisionedIops: 2024
    provisionedBandwidthMibps: 163
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stbuystorefiles001_name_resource
  ]
}

resource storageAccounts_stbuystorefiles001_name_default_hr_files 'Microsoft.Storage/storageAccounts/fileServices/shares@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_default
  name: 'hr-files'
  properties: {
    provisionedIops: 2024
    provisionedBandwidthMibps: 163
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stbuystorefiles001_name_resource
  ]
}

resource storageAccounts_stbuystorefiles001_name_default_it_files 'Microsoft.Storage/storageAccounts/fileServices/shares@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_default
  name: 'it-files'
  properties: {
    provisionedIops: 2024
    provisionedBandwidthMibps: 163
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stbuystorefiles001_name_resource
  ]
}

resource storageAccounts_stbuystorefiles001_name_default_marketing_files 'Microsoft.Storage/storageAccounts/fileServices/shares@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_default
  name: 'marketing-files'
  properties: {
    provisionedIops: 2024
    provisionedBandwidthMibps: 163
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stbuystorefiles001_name_resource
  ]
}

resource storageAccounts_stbuystorefiles001_name_default_operations_files 'Microsoft.Storage/storageAccounts/fileServices/shares@2026-04-01' = {
  parent: storageAccounts_stbuystorefiles001_name_default
  name: 'operations-files'
  properties: {
    provisionedIops: 2024
    provisionedBandwidthMibps: 163
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_stbuystorefiles001_name_resource
  ]
}
