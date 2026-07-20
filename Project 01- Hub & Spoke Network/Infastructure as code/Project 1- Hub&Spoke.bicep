param azureFirewalls_fw_hub_name string = 'fw-hub'
param routeTables_rt_spokes_name string = 'rt-spokes'
param virtualMachines_vm_dev_name string = 'vm-dev'
param virtualMachines_vm_prod_name string = 'vm-prod'
param virtualMachines_vm_test_name string = 'vm-test'
param bastionHosts_bastion_hub_name string = 'bastion-hub'
param virtualNetworks_vnet_dev_name string = 'vnet-dev'
param virtualNetworks_vnet_hub_name string = 'vnet-hub'
param virtualNetworks_vnet_prod_name string = 'vnet-prod'
param virtualNetworks_vnet_test_name string = 'vnet-test'
param networkInterfaces_vm_dev212_name string = 'vm-dev212'
param networkInterfaces_vm_prod145_name string = 'vm-prod145'
param networkInterfaces_vm_prod460_name string = 'vm-prod460'
param networkInterfaces_vm_test714_name string = 'vm-test714'
param publicIPAddresses_vm_prod_ip_name string = 'vm-prod-ip'
param networkSecurityGroups_nsg_dev_name string = 'nsg-dev'
param networkSecurityGroups_nsg_prod_name string = 'nsg-prod'
param networkSecurityGroups_nsg_test_name string = 'nsg-test'
param publicIPAddresses_fw_public_ip_name string = 'fw-public-ip'
param publicIPAddresses_bastion_public_ip_name string = 'bastion-public-ip'

resource networkSecurityGroups_nsg_dev_name_resource 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: networkSecurityGroups_nsg_dev_name
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'Allow-AzureBastion'
        id: networkSecurityGroups_nsg_dev_name_Allow_AzureBastion.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '10.0.2.0/26'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-HTTP'
        id: networkSecurityGroups_nsg_dev_name_Allow_HTTP.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Alllo-HTTPS'
        id: networkSecurityGroups_nsg_dev_name_Alllo_HTTPS.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_prod_name_resource 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: networkSecurityGroups_nsg_prod_name
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP-From-Bastion'
        id: networkSecurityGroups_nsg_prod_name_Allow_RDP_From_Bastion.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '10.0.2.0/26'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-HTTP'
        id: networkSecurityGroups_nsg_prod_name_Allow_HTTP.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-HTTPS'
        id: networkSecurityGroups_nsg_prod_name_Allow_HTTPS.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_test_name_resource 'Microsoft.Network/networkSecurityGroups@2025-07-01' = {
  name: networkSecurityGroups_nsg_test_name
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP-From-Bastion'
        id: networkSecurityGroups_nsg_test_name_Allow_RDP_From_Bastion.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '10.0.2.0/26'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-HTTP'
        id: networkSecurityGroups_nsg_test_name_Allow_HTTP.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Allow-HTTPS'
        id: networkSecurityGroups_nsg_test_name_Allow_HTTPS.id
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_bastion_public_ip_name_resource 'Microsoft.Network/publicIPAddresses@2025-07-01' = {
  name: publicIPAddresses_bastion_public_ip_name
  location: 'eastus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    ipAddress: '20.237.4.194'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_fw_public_ip_name_resource 'Microsoft.Network/publicIPAddresses@2025-07-01' = {
  name: publicIPAddresses_fw_public_ip_name
  location: 'eastus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '52.186.149.90'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource publicIPAddresses_vm_prod_ip_name_resource 'Microsoft.Network/publicIPAddresses@2025-07-01' = {
  name: publicIPAddresses_vm_prod_ip_name
  location: 'eastus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ipAddress: '20.25.57.13'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource routeTables_rt_spokes_name_resource 'Microsoft.Network/routeTables@2025-07-01' = {
  name: routeTables_rt_spokes_name
  location: 'eastus'
  properties: {
    disableBgpRoutePropagation: false
    routes: [
      {
        name: 'Default-to-Firewall'
        id: routeTables_rt_spokes_name_Default_to_Firewall.id
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'VirtualAppliance'
          nextHopIpAddress: '10.0.1.4'
        }
      }
    ]
  }
}

resource virtualMachines_vm_dev_name_resource 'Microsoft.Compute/virtualMachines@2025-11-01' = {
  name: virtualMachines_vm_dev_name
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2als_v7'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_dev_name}_OsDisk_1_e5fe00461da5423a80e6e5a57e043dbe'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm_dev_name}_OsDisk_1_e5fe00461da5423a80e6e5a57e043dbe'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'NVMe'
    }
    osProfile: {
      computerName: virtualMachines_vm_dev_name
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
      adminUsername: 'azureuser'
    }
    securityProfile: {
      securityType: 'Standard'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_dev212_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_vm_prod_name_resource 'Microsoft.Compute/virtualMachines@2025-11-01' = {
  name: virtualMachines_vm_prod_name
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2als_v7'
      vmSizeProperties: {
        vCPUsAvailable: 1
        vCPUsPerCore: 1
      }
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_prod_name}_OsDisk_1_373166babe624a03a2ab4e895c0c797e'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm_prod_name}_OsDisk_1_373166babe624a03a2ab4e895c0c797e'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'NVMe'
    }
    osProfile: {
      computerName: virtualMachines_vm_prod_name
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
      adminUsername: 'azureuser'
    }
    securityProfile: {
      securityType: 'Standard'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_prod460_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource virtualMachines_vm_test_name_resource 'Microsoft.Compute/virtualMachines@2025-11-01' = {
  name: virtualMachines_vm_test_name
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2als_v7'
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${virtualMachines_vm_test_name}_OsDisk_1_f4d3ce34775c42cf8af973b062ce48e3'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
          id: resourceId(
            'Microsoft.Compute/disks',
            '${virtualMachines_vm_test_name}_OsDisk_1_f4d3ce34775c42cf8af973b062ce48e3'
          )
        }
        deleteOption: 'Delete'
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'NVMe'
    }
    osProfile: {
      computerName: virtualMachines_vm_test_name
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
      adminUsername: 'azureuser'
    }
    securityProfile: {
      securityType: 'Standard'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_test714_name_resource.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource networkInterfaces_vm_dev212_name_resource 'Microsoft.Network/networkInterfaces@2025-07-01' = {
  name: networkInterfaces_vm_dev212_name
  location: 'eastus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_dev212_name_resource.id}/ipConfigurations/ipconfig1'
        properties: {
          privateIPAddress: '10.2.1.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_dev_name_DevelopmentSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_prod460_name_resource 'Microsoft.Network/networkInterfaces@2025-07-01' = {
  name: networkInterfaces_vm_prod460_name
  location: 'eastus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_prod460_name_resource.id}/ipConfigurations/ipconfig1'
        properties: {
          privateIPAddress: '10.1.1.5'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_prod_name_ProductionSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkInterfaces_vm_test714_name_resource 'Microsoft.Network/networkInterfaces@2025-07-01' = {
  name: networkInterfaces_vm_test714_name
  location: 'eastus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_test714_name_resource.id}/ipConfigurations/ipconfig1'
        properties: {
          privateIPAddress: '10.3.1.4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: virtualNetworks_vnet_test_name_TestingSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkSecurityGroups_nsg_dev_name_Alllo_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_dev_name}/Alllo-HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_dev_name_resource
  ]
}

resource networkSecurityGroups_nsg_dev_name_Allow_AzureBastion 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_dev_name}/Allow-AzureBastion'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '10.0.2.0/26'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_dev_name_resource
  ]
}

resource networkSecurityGroups_nsg_dev_name_Allow_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_dev_name}/Allow-HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_dev_name_resource
  ]
}

resource networkSecurityGroups_nsg_prod_name_Allow_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_prod_name}/Allow-HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_prod_name_resource
  ]
}

resource networkSecurityGroups_nsg_test_name_Allow_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_test_name}/Allow-HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_test_name_resource
  ]
}

resource networkSecurityGroups_nsg_prod_name_Allow_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_prod_name}/Allow-HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_prod_name_resource
  ]
}

resource networkSecurityGroups_nsg_test_name_Allow_HTTPS 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_test_name}/Allow-HTTPS'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_test_name_resource
  ]
}

resource networkSecurityGroups_nsg_prod_name_Allow_RDP_From_Bastion 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_prod_name}/Allow-RDP-From-Bastion'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '10.0.2.0/26'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_prod_name_resource
  ]
}

resource networkSecurityGroups_nsg_test_name_Allow_RDP_From_Bastion 'Microsoft.Network/networkSecurityGroups/securityRules@2025-07-01' = {
  name: '${networkSecurityGroups_nsg_test_name}/Allow-RDP-From-Bastion'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '3389'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '10.0.2.0/26'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_nsg_test_name_resource
  ]
}

resource routeTables_rt_spokes_name_Default_to_Firewall 'Microsoft.Network/routeTables/routes@2025-07-01' = {
  name: '${routeTables_rt_spokes_name}/Default-to-Firewall'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: '10.0.1.4'
  }
  dependsOn: [
    routeTables_rt_spokes_name_resource
  ]
}

resource virtualNetworks_vnet_hub_name_AzureBastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_hub_name}/AzureBastionSubnet'
  properties: {
    addressPrefixes: [
      '10.0.2.0/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_hub_name_resource
  ]
}

resource virtualNetworks_vnet_hub_name_AzureFirewallSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_hub_name}/AzureFirewallSubnet'
  properties: {
    addressPrefixes: [
      '10.0.1.0/26'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_hub_name_resource
  ]
}

resource virtualNetworks_vnet_hub_name_SharedServices 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_hub_name}/SharedServices'
  properties: {
    addressPrefixes: [
      '10.0.3.0/24'
    ]
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_hub_name_resource
  ]
}

resource azureFirewalls_fw_hub_name_resource 'Microsoft.Network/azureFirewalls@2025-07-01' = {
  name: azureFirewalls_fw_hub_name
  location: 'eastus'
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    threatIntelMode: 'Alert'
    additionalProperties: {}
    ipConfigurations: [
      {
        name: 'fw-public-ip'
        id: '${azureFirewalls_fw_hub_name_resource.id}/azureFirewallIpConfigurations/fw-public-ip'
        properties: {
          publicIPAddress: {
            id: publicIPAddresses_fw_public_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_hub_name_AzureFirewallSubnet.id
          }
        }
      }
    ]
    networkRuleCollections: [
      {
        name: 'Allow-Spoke-Traffic'
        id: '${azureFirewalls_fw_hub_name_resource.id}/networkRuleCollections/Allow-Spoke-Traffic'
        properties: {
          priority: 100
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'Allow-All-Spokes'
              protocols: [
                'Any'
                'ICMP'
                'UDP'
                'TCP'
              ]
              sourceAddresses: [
                '10.1.0.0/16'
                '10.2.0.0/16'
                '10.3.0.0/16'
              ]
              destinationAddresses: [
                '10.1.0.0/16'
                '10.2.0.0/16'
                '10.3.0.0/16'
              ]
              sourceIpGroups: []
              destinationIpGroups: []
              destinationFqdns: []
              destinationPorts: [
                '*'
              ]
            }
          ]
        }
      }
    ]
    applicationRuleCollections: []
    natRuleCollections: []
  }
}

resource bastionHosts_bastion_hub_name_resource 'Microsoft.Network/bastionHosts@2025-07-01' = {
  name: bastionHosts_bastion_hub_name
  location: 'eastus'
  sku: {
    name: 'Standard'
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    dnsName: 'bst-7ea82cfe-6a54-4d54-b6c7-8c8c5291650c.bastion.azure.com'
    scaleUnits: 2
    enableTunneling: false
    enableIpConnect: false
    disableCopyPaste: false
    enableShareableLink: true
    enableKerberos: false
    enableSessionRecording: false
    enablePrivateOnlyBastion: false
    ipConfigurations: [
      {
        name: 'IpConf'
        id: '${bastionHosts_bastion_hub_name_resource.id}/bastionHostIpConfigurations/IpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_bastion_public_ip_name_resource.id
          }
          subnet: {
            id: virtualNetworks_vnet_hub_name_AzureBastionSubnet.id
          }
        }
      }
    ]
  }
}

resource networkInterfaces_vm_prod145_name_resource 'Microsoft.Network/networkInterfaces@2025-07-01' = {
  name: networkInterfaces_vm_prod145_name
  location: 'eastus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_prod145_name_resource.id}/ipConfigurations/ipconfig1'
        properties: {
          privateIPAddress: '10.1.1.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_vm_prod_ip_name_resource.id
            properties: {
              deleteOption: 'Detach'
            }
          }
          subnet: {
            id: virtualNetworks_vnet_prod_name_ProductionSubnet.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource virtualNetworks_vnet_hub_name_dev_to_hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  name: '${virtualNetworks_vnet_hub_name}/dev-to-hub'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_dev_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_hub_name_resource
  ]
}

resource virtualNetworks_vnet_dev_name_hub_to_dev 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  name: '${virtualNetworks_vnet_dev_name}/hub-to-dev'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_hub_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_dev_name_resource
  ]
}

resource virtualNetworks_vnet_prod_name_hub_to_prod 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  name: '${virtualNetworks_vnet_prod_name}/hub-to-prod'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_hub_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_prod_name_resource
  ]
}

resource virtualNetworks_vnet_test_name_hub_to_test 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  name: '${virtualNetworks_vnet_test_name}/hub-to-test'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_hub_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_test_name_resource
  ]
}

resource virtualNetworks_vnet_hub_name_prod_to_hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  name: '${virtualNetworks_vnet_hub_name}/prod-to-hub'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_prod_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_hub_name_resource
  ]
}

resource virtualNetworks_vnet_hub_name_test_to_hub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2025-07-01' = {
  name: '${virtualNetworks_vnet_hub_name}/test-to-hub'
  properties: {
    peeringState: 'Connected'
    peeringSyncLevel: 'FullyInSync'
    remoteVirtualNetwork: {
      id: virtualNetworks_vnet_test_name_resource.id
    }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    doNotVerifyRemoteGateways: false
    peerCompleteVnets: true
    enableOnlyIPv6Peering: false
    remoteAddressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
  }
  dependsOn: [
    virtualNetworks_vnet_hub_name_resource
  ]
}

resource virtualNetworks_vnet_dev_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vnet_dev_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'DevelopmentSubnet'
        id: virtualNetworks_vnet_dev_name_DevelopmentSubnet.id
        properties: {
          addressPrefixes: [
            '10.2.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_dev_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_spokes_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'hub-to-dev'
        id: virtualNetworks_vnet_dev_name_hub_to_dev.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_hub_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_hub_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vnet_hub_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        id: virtualNetworks_vnet_hub_name_AzureFirewallSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.1.0/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'SharedServices'
        id: virtualNetworks_vnet_hub_name_SharedServices.id
        properties: {
          addressPrefixes: [
            '10.0.3.0/24'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
      {
        name: 'AzureBastionSubnet'
        id: virtualNetworks_vnet_hub_name_AzureBastionSubnet.id
        properties: {
          addressPrefixes: [
            '10.0.2.0/26'
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'prod-to-hub'
        id: virtualNetworks_vnet_hub_name_prod_to_hub.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_prod_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.1.0.0/16'
            ]
          }
        }
      }
      {
        name: 'dev-to-hub'
        id: virtualNetworks_vnet_hub_name_dev_to_hub.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_dev_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.2.0.0/16'
            ]
          }
        }
      }
      {
        name: 'test-to-hub'
        id: virtualNetworks_vnet_hub_name_test_to_hub.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_test_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.3.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.3.0.0/16'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_prod_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vnet_prod_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'ProductionSubnet'
        id: virtualNetworks_vnet_prod_name_ProductionSubnet.id
        properties: {
          addressPrefixes: [
            '10.1.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_prod_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_spokes_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'hub-to-prod'
        id: virtualNetworks_vnet_prod_name_hub_to_prod.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_hub_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_test_name_resource 'Microsoft.Network/virtualNetworks@2025-07-01' = {
  name: virtualNetworks_vnet_test_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.3.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'TestingSubnet'
        id: virtualNetworks_vnet_test_name_TestingSubnet.id
        properties: {
          addressPrefixes: [
            '10.3.1.0/24'
          ]
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_test_name_resource.id
          }
          routeTable: {
            id: routeTables_rt_spokes_name_resource.id
          }
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: [
      {
        name: 'hub-to-test'
        id: virtualNetworks_vnet_test_name_hub_to_test.id
        properties: {
          peeringState: 'Connected'
          peeringSyncLevel: 'FullyInSync'
          remoteVirtualNetwork: {
            id: virtualNetworks_vnet_hub_name_resource.id
          }
          allowVirtualNetworkAccess: true
          allowForwardedTraffic: true
          allowGatewayTransit: false
          useRemoteGateways: false
          doNotVerifyRemoteGateways: false
          peerCompleteVnets: true
          enableOnlyIPv6Peering: false
          remoteAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
          remoteVirtualNetworkAddressSpace: {
            addressPrefixes: [
              '10.0.0.0/16'
            ]
          }
        }
      }
    ]
    enableDdosProtection: false
  }
}

resource virtualNetworks_vnet_dev_name_DevelopmentSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_dev_name}/DevelopmentSubnet'
  properties: {
    addressPrefixes: [
      '10.2.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_dev_name_resource.id
    }
    routeTable: {
      id: routeTables_rt_spokes_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_dev_name_resource
  ]
}

resource virtualNetworks_vnet_prod_name_ProductionSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_prod_name}/ProductionSubnet'
  properties: {
    addressPrefixes: [
      '10.1.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_prod_name_resource.id
    }
    routeTable: {
      id: routeTables_rt_spokes_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_prod_name_resource
  ]
}

resource virtualNetworks_vnet_test_name_TestingSubnet 'Microsoft.Network/virtualNetworks/subnets@2025-07-01' = {
  name: '${virtualNetworks_vnet_test_name}/TestingSubnet'
  properties: {
    addressPrefixes: [
      '10.3.1.0/24'
    ]
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_test_name_resource.id
    }
    routeTable: {
      id: routeTables_rt_spokes_name_resource.id
    }
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_vnet_test_name_resource
  ]
}
