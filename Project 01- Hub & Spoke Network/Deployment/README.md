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

Secure browser-based access to virtual machines without exposing Public IP addresses.

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

