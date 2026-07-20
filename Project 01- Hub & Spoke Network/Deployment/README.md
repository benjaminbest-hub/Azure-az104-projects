# Azure Deployment

## Resources Deployed

| Resource | Name |
|----------|------|
| Resource Group | rg-hubspoke-lab |
| Virtual Network | vnet-eastus |
| Azure Firewall Subnet | AzureFirewallSubnet |
| Azure Bastion Subnet | AzureBastionSubnet |
| Shared Services Subnet | SharedServices |
| Bastion Host | bastion-hub |
| Public IP | bastion-public-ip |

---

## Deployment Steps

1. Created Resource Group
2. Created Hub Virtual Network
3. Added Address Space
4. Created AzureFirewallSubnet
5. Created AzureBastionSubnet
6. Created SharedServices subnet
7. Deployed Azure Bastion Host

# Deployment Notes

## Resource Group

rg-hubspoke-lab

Location

East US

---

## Hub Network

Name

vnet-hub

Address Space

10.0.0.0/16

---

## Azure Firewall

Name

fw-hub

Private IP

10.0.1.4

Subnet

AzureFirewallSubnet

---

## Azure Bastion

Purpose

Secure browser based access to virtual machines without exposing Public IP addresses.

---

## Virtual Networks

Development

vnet-dev

10.2.0.0/16

Production

vnet-prod

10.1.0.0/16

Testing

vnet-test

10.3.0.0/16

---

## Subnets

DevelopmentSubnet

10.2.1.0/24

ProductionSubnet

10.1.1.0/24

TestingSubnet

10.3.1.0/24

---

## Route Table

Name

rt-spokes

Default Route

0.0.0.0/0

Next Hop

Virtual Appliance

Firewall IP

10.0.1.4

---

## Network Security Groups

nsg-dev

nsg-prod

nsg-test

# Deployment Notes

## Project Overview

This document outlines the Microsoft Azure resources deployed for the **Secure Hub-and-Spoke Network Architecture** project.

Each Azure component plays a specific role in delivering a secure, scalable, isolated, and centrally managed enterprise network environment.

The project consists of:

- One Hub Virtual Network
- Three Spoke Virtual Networks
- Azure Firewall
- Azure Bastion
- Network Security Groups
- Route Tables and User Defined Routes
- Virtual Network Peering
- Three Windows Virtual Machines
- Azure Network Watcher diagnostics
- Infrastructure as Code templates

---

# Architecture Summary

## Hub-and-Spoke Architecture

The environment was designed using the **Hub-and-Spoke network topology**.

The Hub Virtual Network provides centralized networking and security services, while separate Spoke Virtual Networks host the Production, Development, and Testing workloads.

The Hub contains:

- Azure Firewall
- Azure Bastion
- Shared networking services

The Spokes contain:

- Production workloads
- Development workloads
- Testing workloads

This architecture provides:

- Centralized security management
- Network isolation
- Controlled communication
- Easier administration
- Improved scalability
- Reduced operational complexity
- Support for future expansion

---

# Resource Group

## What is a Resource Group?

A Resource Group is a logical container in Microsoft Azure that holds related resources for a particular solution or workload.

It simplifies:

- Resource management
- Access control
- Monitoring
- Cost tracking
- Deployment
- Resource deletion

Resources within a Resource Group can be managed together as a single administrative unit.

## Deployment Details

| Property | Value |
|---|---|
| Resource Group Name | `rg-hubspoke-lab` |
| Azure Region | `East US` |

---

# Virtual Network

## What is an Azure Virtual Network?

An Azure Virtual Network, commonly called a VNet, is a private and isolated network in Microsoft Azure.

It allows Azure resources to communicate securely with:

- Other Azure resources
- Other Virtual Networks
- The Internet
- On-premises networks

An Azure VNet functions similarly to a traditional network in a physical data centre.

---

# Hub Virtual Network

## Purpose

The Hub Virtual Network serves as the central network for shared security, connectivity, and management services.

It hosts Azure Firewall and Azure Bastion and connects to all Spoke Virtual Networks through VNet Peering.

## Deployment Details

| Property | Value |
|---|---|
| VNet Name | `vnet-hub` |
| Address Space | `10.0.0.0/16` |
| Purpose | Centralized security and connectivity |

---

# Spoke Virtual Networks

## Purpose

Separate Spoke Virtual Networks were created for Production, Development, and Testing.

This design isolates workloads while allowing controlled communication through the Hub Virtual Network.

## Deployment Details

| Environment | Virtual Network | Address Space |
|---|---|---|
| Production | `vnet-prod` | `10.1.0.0/16` |
| Development | `vnet-dev` | `10.2.0.0/16` |
| Testing | `vnet-test` | `10.3.0.0/16` |

## Why Separate VNets Were Used

Separate VNets provide:

- Environment isolation
- Reduced security risk
- Independent administration
- Easier troubleshooting
- Better access control
- Reduced impact if one environment is compromised
- Support for environment-specific policies

---

# Subnets

## What is a Subnet?

A subnet is a smaller network segment created inside a Virtual Network.

Subnets help organize resources and allow security controls, routing policies, and network configurations to be applied to specific groups of resources.

## Deployment Details

| Virtual Network | Subnet | Address Range |
|---|---|---|
| `vnet-prod` | `ProductionSubnet` | `10.1.1.0/24` |
| `vnet-dev` | `DevelopmentSubnet` | `10.2.1.0/24` |
| `vnet-test` | `TestingSubnet` | `10.3.1.0/24` |

## Hub Subnets

The Hub VNet also contains dedicated subnets for Azure networking services.

| Subnet | Purpose |
|---|---|
| `AzureFirewallSubnet` | Hosts Azure Firewall |
| `AzureBastionSubnet` | Hosts Azure Bastion |

> The exact address prefixes for the Azure Firewall and Azure Bastion subnets should match the values configured in the Azure Portal.

---

# Azure Firewall

## What is Azure Firewall?

Azure Firewall is a fully managed, stateful network security service provided by Microsoft Azure.

It inspects and filters network traffic according to configured rules.

Azure Firewall can control:

- Inbound traffic
- Outbound traffic
- Traffic between internal Azure networks
- Network-level traffic
- Application-level traffic
- Threat intelligence-based traffic

## Why Azure Firewall Was Used

Azure Firewall was deployed as the centralized security appliance for the architecture.

Instead of allowing traffic to move freely between environments, traffic is directed through Azure Firewall for inspection and policy enforcement.

This provides:

- Centralized network security
- Consistent rule management
- Traffic inspection
- Improved visibility
- Support for logging and monitoring
- Controlled east-west communication
- Controlled outbound Internet access

## Deployment Details

| Property | Value |
|---|---|
| Firewall Name | `fw-hub` |
| Private IP Address | `10.0.1.4` |
| Subnet | `AzureFirewallSubnet` |
| Public IP Address | `20.75.234.0` |

## Firewall Rule Configuration

A network rule collection was created to allow communication between the three Spoke Virtual Networks.

| Property | Value |
|---|---|
| Rule Collection Name | `Allow-Spoke-Traffic` |
| Priority | `100` |
| Action | `Allow` |
| Protocols | `Any` |
| Destination Ports | `*` |

### Source Networks

- `10.1.0.0/16`
- `10.2.0.0/16`
- `10.3.0.0/16`

### Destination Networks

- `10.1.0.0/16`
- `10.2.0.0/16`
- `10.3.0.0/16`

---

# Azure Bastion

## What is Azure Bastion?

Azure Bastion is a managed service that provides secure RDP and SSH access to Azure Virtual Machines directly from the Azure Portal.

It allows administrators to connect to virtual machines without assigning public IP addresses to the VMs.

## Why Azure Bastion Was Used

Azure Bastion was used to securely manage the virtual machines.

It avoids exposing administrative ports directly to the Internet.

Common administrative ports include:

- TCP `3389` for Remote Desktop Protocol
- TCP `22` for Secure Shell

Azure Bastion provides:

- Browser-based VM access
- Reduced Internet exposure
- No public IP requirement for VMs
- Reduced attack surface
- Secure administrative connectivity

---

# Virtual Network Peering

## What is Virtual Network Peering?

Virtual Network Peering connects two Azure Virtual Networks and allows resources in those networks to communicate using private IP addresses.

Traffic between peered VNets travels across Microsoft's private backbone network rather than the public Internet.

## Why VNet Peering Was Used

Each Spoke VNet was peered with the Hub VNet.

This enabled the Production, Development, and Testing networks to access centralized Hub services.

## Peering Relationships

The following peerings were configured:

- `vnet-hub` ↔ `vnet-prod`
- `vnet-hub` ↔ `vnet-dev`
- `vnet-hub` ↔ `vnet-test`

## Peering Status

All peerings were confirmed as:

- Connected
- Fully synchronized

## Design Note

The Spoke VNets were not directly peered with one another.

Communication between Spokes was designed to pass through the Hub and Azure Firewall.

---

# Route Table

## What is an Azure Route Table?

An Azure Route Table contains routes that determine how network traffic is forwarded.

Azure automatically creates system routes, but custom routes can be created when a specific traffic path is required.

These custom routes are called **User Defined Routes**, or UDRs.

## Why a Route Table Was Used

Azure can route traffic directly between peered Virtual Networks using system routes.

A User Defined Route was created to redirect traffic to Azure Firewall instead.

This ensures that traffic is inspected before it reaches its destination.

## Deployment Details

| Property | Value |
|---|---|
| Route Table Name | `rt-spokes` |
| Route Prefix | `0.0.0.0/0` |
| Next Hop Type | `Virtual Appliance` |
| Next Hop IP Address | `10.0.1.4` |

## Route Table Associations

The route table was associated with:

- `ProductionSubnet`
- `DevelopmentSubnet`
- `TestingSubnet`

## Traffic Flow

The configured route results in the following traffic path:

```text
Source Virtual Machine
        |
        v
Spoke Subnet
        |
        v
Route Table: rt-spokes
        |
        v
Azure Firewall: 10.0.1.4
        |
        v
Destination Network
