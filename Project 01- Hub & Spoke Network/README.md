# Project 01 - Secure Hub-and-Spoke Virtual Network Architecture

## Overview

This project demonstrates the design and deployment of a secure Hub-and-Spoke network topology in Microsoft Azure.

The environment was built using Azure Virtual Networks and subnet segmentation to prepare for enterprise networking scenarios commonly found in production environments.

This project forms part of my Azure Administrator (AZ-104) portfolio.

---

## Objectives

- Design a scalable virtual network architecture
- Deploy a Hub Virtual Network
- Create dedicated subnets for Azure Firewall
- Configure Azure Bastion subnet
- Deploy a Shared Services subnet
- Prepare the environment for future spoke networks
- Follow Microsoft networking best practices

---

## Azure Resources

| Resource | Configuration |
|----------|--------------|
| Resource Group | rg-hubspoke-lab |
| Hub Virtual Network | vnet-hub |
| Address Space | 10.0.0.0/16 |
| Azure Firewall Subnet | AzureFirewallSubnet |
| Azure Bastion Subnet | AzureBastionSubnet |
| Shared Services Subnet | SharedServices |

---

## Address Plan

| Subnet | Address Range |
|---------|---------------|
| AzureFirewallSubnet | 10.0.1.0/26 |
| AzureBastionSubnet | 10.0.2.0/26 |
| SharedServices | 10.0.3.0/24 |

---

## Architecture

```
                    Internet
                        |
                Azure Firewall
                        |
        -------------------------------
        |                             |
   Shared Services               Future Spokes
```

*A graphical architecture diagram will be added in the Architecture folder.*

---

## Skills Demonstrated

- Azure Virtual Networks
- Network Segmentation
- Azure Subnets
- Azure Address Planning
- Hub-and-Spoke Network Design
- Azure Networking
- Azure Administration

---

## Deployment Steps

### Step 1

Created a Resource Group.

### Step 2

Created the Hub Virtual Network.

Address Space

```
10.0.0.0/16
```

### Step 3

Created the following subnets:

- AzureFirewallSubnet
- AzureBastionSubnet
- SharedServices

### Step 4

Validated subnet deployment.

### Step 5

Prepared the network for Azure Firewall, Azure Bastion, and future spoke VNets.

---

## Screenshots

Screenshots are available in the **Screenshots** folder.

Examples include:

- Resource Group
- Hub Virtual Network
- Address Space
- Azure Firewall Subnet
- Azure Bastion Subnet
- Shared Services Subnet

---

## Lessons Learned

- Azure Firewall requires a subnet named **AzureFirewallSubnet**.
- Azure Bastion requires a subnet named **AzureBastionSubnet**.
- Proper subnet sizing is essential for future scalability.
- Hub-and-Spoke architecture simplifies network management and improves security.

---

## Future Improvements

- Deploy Azure Firewall
- Deploy Azure Bastion
- Create multiple Spoke VNets
- Configure VNet Peering
- Configure Network Security Groups
- Implement User Defined Routes
- Enable Azure Network Watcher

---

## Technologies Used

- Microsoft Azure
- Azure Portal
- Azure Virtual Network
- Azure Firewall
- Azure Bastion
- GitHub
- Markdown
## Progress

- ✅ Created Hub Virtual Network
- ✅ Created Azure Firewall
- ✅ Created Azure Bastion
- ✅ Created Production VNet
- ✅ Created Development VNet
- ✅ Created Testing VNet
- ✅ Configured Hub-and-Spoke Peering
- ✅ Created Network Security Groups
- ✅ Associated NSGs with Subnets
- ✅ Created Route Table
- ✅ Forced Internet Traffic Through Azure Firewall
- ⏳ Deploying Virtual Machines

