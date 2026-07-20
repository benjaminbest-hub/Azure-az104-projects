# Deployment Notes

| Property | Value |
|---|---|
| Project | Secure Hub-and-Spoke Network Architecture |
| Platform | Microsoft Azure |
| Project Type | Azure Administrator (AZ-104) Portfolio Project |
| Author | Benjamin Okeh |
| Region | East US |

---

## Project Overview

This document outlines the Microsoft Azure resources deployed for the Secure Hub & Spoke Network Architecture project. The environment uses a Hub & Spoke topology to provide centralized security, network isolation, and simplified administration.

## Architecture Summary

The Hub Virtual Network hosts Azure Firewall and Azure Bastion. Three Spoke Virtual Networks (Production, Development, and Testing) connect to the Hub using Virtual Network Peering. User Defined Routes direct traffic through Azure Firewall for centralized inspection.

# Resource Group

| Property | Value |
|---|---|
| Resource Group | `rg-hubspoke-lab` |
| Region | `East US` |

# Hub Virtual Network

| Property | Value |
|---|---|
| Name | `vnet-hub` |
| Address Space | `10.0.0.0/16` |

# Spoke Virtual Networks

| Environment | Virtual Network | Address Space |
|---|---|---|
| Production | `vnet-prod` | `10.1.0.0/16` |
| Development | `vnet-dev` | `10.2.0.0/16` |
| Testing | `vnet-test` | `10.3.0.0/16` |

# Subnets

| Subnet | Address Prefix |
|---|---|
| ProductionSubnet | `10.1.1.0/24` |
| DevelopmentSubnet | `10.2.1.0/24` |
| TestingSubnet | `10.3.1.0/24` |
| AzureFirewallSubnet | Hub VNet |
| AzureBastionSubnet | Hub VNet |

# Azure Firewall

| Property | Value |
|---|---|
| Name | `fw-hub` |
| Private IP | `10.0.1.4` |
| Subnet | `AzureFirewallSubnet` |

Azure Firewall provides centralized inspection of inbound, outbound, and east-west traffic.

# Azure Bastion

| Property | Value |
|---|---|
| Name | `bastion-hub` |
| Subnet | `AzureBastionSubnet` |
| Public IP | `bastion-public-ip` |

Azure Bastion provides secure browser-based RDP and SSH access without exposing public IP addresses.

# Virtual Network Peering

- `vnet-hub` ↔ `vnet-prod`
- `vnet-hub` ↔ `vnet-dev`
- `vnet-hub` ↔ `vnet-test`

# Route Table

| Property | Value |
|---|---|
| Name | `rt-spokes` |
| Route | `0.0.0.0/0` |
| Next Hop | Virtual Appliance |
| Next Hop IP | `10.0.1.4` |

# Network Security Groups

- `nsg-prod`
- `nsg-dev`
- `nsg-test`

# Virtual Machines

| VM | Environment | Private IP |
|---|---|---|
| `vm-prod` | Production | `10.1.1.5` |
| `vm-dev` | Development | `10.2.1.4` |
| `vm-test` | Testing | `10.3.1.4` |

# Azure Network Watcher

Validated:
- Effective Routes
- Next Hop
- VM Connectivity

# Troubleshooting

Issue: Windows Defender Firewall blocked ICMP Echo Requests.

Resolution: Enabled **File and Printer Sharing (Echo Request - ICMPv4-In)**.

# Infrastructure as Code

Deployment exported as:
- ARM
- Bicep
- Terraform

# Skills Demonstrated

- Azure Virtual Networks
- Hub-and-Spoke Architecture
- Azure Firewall
- Azure Bastion
- Route Tables
- User Defined Routes
- Network Security Groups
- Azure Network Watcher
- Virtual Network Peering
- Azure Virtual Machines
- Infrastructure as Code
- Git & GitHub

# Conclusion

The project demonstrates the deployment, validation, troubleshooting, and documentation of a secure enterprise Azure Hub & Spoke network.