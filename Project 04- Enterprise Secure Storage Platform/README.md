# Enterprise Secure Storage Platform for Buystore

## Project Overview

This project demonstrates the design and implementation of a secure, enterprise-grade Azure Storage platform for **Buystore**, a fictional e-commerce company. The solution was designed using Microsoft Azure best practices with a strong focus on security, identity management, private networking, governance, data protection, operational resilience, and cost optimization.

Rather than deploying a simple storage account, this project simulates a real-world enterprise storage environment where different business units securely store and manage business-critical information while maintaining strict access controls and minimizing exposure to the public internet.

---

# Business Scenario

Buystore is a rapidly growing e-commerce organization with multiple departments including Finance, Human Resources, Marketing, Operations, and Information Technology.

As the company expands, data is generated across several business functions including financial records, employee documents, marketing assets, product images, and application backups.

The existing environment presents several challenges:

- Business files are scattered across different storage locations.
- Departments require isolated access to sensitive information.
- There is no centralized disaster recovery strategy.
- Storage costs continue to increase as data grows.
- Public access to storage resources introduces unnecessary security risks.

The objective of this project is to design and implement a centralized, secure, scalable, and highly available Azure Storage platform capable of supporting the company's current operations while providing a foundation for future growth.

---

# Business Requirements

## Security Requirements

- Prevent anonymous access to storage resources.
- Restrict access using Microsoft Entra ID.
- Implement Role-Based Access Control (RBAC).
- Ensure secure communication using TLS.
- Remove dependency on public internet connectivity.
- Implement least privilege access.

## Data Protection Requirements

- Protect against accidental deletion.
- Maintain previous versions of files.
- Provide disaster recovery capability.
- Enable recovery of deleted containers and file shares.
- Support backup and recovery operations.

## Governance Requirements

- Implement resource tagging.
- Protect resources using Resource Locks.
- Apply lifecycle policies for storage optimization.
- Ensure standardized resource organization.

## Cost Optimization Requirements

- Automatically move infrequently accessed data to lower-cost storage tiers.
- Remove unnecessary historical versions.
- Reduce long-term storage costs through lifecycle management.

---

# Solution Architecture

The solution consists of two dedicated Azure Storage Accounts.

## Blob Storage Platform

**Storage Account**

`stbuystoredata001`

**Purpose**

- Product Images
- Company Documents
- Finance Documents
- Marketing Assets
- Application Backups
- Human Resources Records

## Azure Files Platform

**Storage Account**

`stbuystorefiles001`

**Purpose**

- Department Shared Drives
- SMB File Sharing
- Team Collaboration
- Department File Storage

---

# Azure Services Used

| Azure Service | Purpose |
|---------------|---------|
| Azure Storage Accounts | Enterprise storage platform |
| Azure Blob Storage | Object storage |
| Azure Files | SMB file sharing |
| Microsoft Entra ID | Identity management |
| Azure Role-Based Access Control (RBAC) | Authorization |
| Azure Private Endpoints | Private connectivity |
| Azure Private DNS Zones | Name resolution |
| Azure Backup | Data protection |
| Azure Lifecycle Management | Cost optimization |
| Azure Resource Locks | Governance |
| Azure Virtual Network | Private networking |

---

# Storage Architecture

## Blob Containers

| Container | Purpose |
|-----------|----------|
| application-backups | Application backups |
| company-documents | Corporate documentation |
| finance-documents | Financial records |
| hr-records | Human Resources documents |
| marketing-assets | Marketing content |
| product-images | Product catalog images |

## Azure File Shares

| File Share | Department |
|------------|------------|
| finance-files | Finance |
| hr-files | Human Resources |
| marketing-files | Marketing |
| operations-files | Operations |
| it-files | Information Technology |

---

# Security Architecture

The platform was designed using a layered security approach.

## Identity Security

- Microsoft Entra Security Groups
- Azure Role-Based Access Control (RBAC)
- Department-based authorization
- Principle of Least Privilege

## Network Security

- Private Endpoints
- Private DNS Zones
- Public Network Access Disabled
- Microsoft Backbone Connectivity

## Data Protection

- Blob Versioning
- Blob Soft Delete
- Container Soft Delete
- File Share Soft Delete
- Azure Backup
- Geo-Redundant Storage (GRS)

## Governance

- Azure Resource Locks
- Resource Tagging
- Lifecycle Management Policies

---

# Azure Resources Deployed

## Resource Group

- `rg-buystore-storage`

## Virtual Network

- `vnet-buystore-storage`

## Subnets

- `snet-private-endpoints`
- `snet-management`

## Storage Accounts

- `stbuystoredata001`
- `stbuystorefiles001`

## Private Endpoints

- `pep-buystore-blob`
- `pep-buystore-file`

## Private DNS Zones

- `privatelink.blob.core.windows.net`
- `privatelink.file.core.windows.net`

## Microsoft Entra Security Groups

- `SG-Buystore-ITAdmins`
- `SG-Buystore-Finance`
- `SG-Buystore-HR`
- `SG-Buystore-Marketing`
- `SG-Buystore-Operations`

---

# Enterprise Design Decisions

Several architectural decisions were made during the implementation of this solution.

- Separate storage accounts were created for Azure Blob Storage and Azure Files to isolate workloads, simplify administration, and reduce operational risk.
- Microsoft Entra Security Groups were used instead of assigning permissions directly to users, providing a scalable and manageable identity model.
- Azure RBAC was implemented using the Principle of Least Privilege to ensure departments only access resources required for their responsibilities.
- Private Endpoints were deployed for both storage accounts so that all traffic remains on Microsoft's private backbone network.
- Public Network Access was disabled only after Private Endpoints and Private DNS were fully validated.
- Lifecycle Management policies were configured to automatically optimize storage costs.
- Geo-Redundant Storage (GRS) was selected to improve disaster recovery capabilities.
- Resource Locks were implemented to prevent accidental deletion of critical production resources.

---

# Skills Demonstrated

This project demonstrates practical experience with:

- Azure Storage Architecture
- Azure Blob Storage
- Azure Files
- Microsoft Entra ID
- Azure RBAC
- Azure Private Link
- Azure Private DNS
- Azure Virtual Networking
- Azure Backup
- Azure Lifecycle Management
- Azure Resource Locks
- Enterprise Identity Management
- Enterprise Storage Design
- Disaster Recovery Planning
- Cost Optimization
- Security Architecture
- Azure Governance

---

# Future Improvements

Potential enhancements include:

- Infrastructure as Code (Bicep)
- Infrastructure as Code (Terraform)
- Azure Policy
- Microsoft Defender for Storage
- Azure Monitor
- Azure Log Analytics
- Azure Key Vault
- Immutable Blob Storage
- Storage Analytics
- Automated Compliance Reporting

---

# Project Outcome

The project successfully delivered a secure, scalable, enterprise-grade Azure Storage platform for Buystore.

The final solution provides:

- Secure private connectivity using Azure Private Link.
- Department-based authorization using Microsoft Entra ID and Azure RBAC.
- Comprehensive data protection through versioning, soft delete, backup, and geo-redundancy.
- Governance controls through Resource Locks, tagging, and lifecycle management.
- Reduced operational risk through workload isolation and least privilege access.
- Cost optimization through automated storage lifecycle policies.
- A production-ready storage architecture aligned with Microsoft Azure best practices.