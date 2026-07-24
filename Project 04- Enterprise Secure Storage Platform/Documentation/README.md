# Design Decisions

## Project

Enterprise Secure Storage Platform for Buystore

---

# Overview

This document explains the architectural decisions made during the design and implementation of the Enterprise Secure Storage Platform. Each decision was made to align with Microsoft Azure best practices while balancing security, scalability, governance, operational efficiency, and cost optimization.

---

# Design Decision 1

## Separate Azure Blob Storage and Azure Files

### Decision

Two dedicated storage accounts were deployed:

- stbuystoredata001
- stbuystorefiles001

### Reason

Although Azure allows both Blob Storage and Azure Files to coexist within a single Storage Account, separating them provides several enterprise benefits.

Benefits include:

- Better workload isolation
- Independent lifecycle management
- Easier RBAC administration
- Reduced operational risk
- Simplified monitoring
- Better scalability

### Trade-off

Managing two storage accounts introduces slightly more administrative overhead, but significantly improves security and operational flexibility.

---

# Design Decision 2

## Microsoft Entra Security Groups Instead of Individual Users

### Decision

Permissions were assigned to Microsoft Entra Security Groups rather than directly to user accounts.

Groups created:

- SG-Buystore-Finance
- SG-Buystore-HR
- SG-Buystore-Marketing
- SG-Buystore-Operations
- SG-Buystore-ITAdmins

### Reason

Enterprise environments should never assign permissions directly to individual employees.

Adding or removing staff becomes a group membership change instead of modifying Azure RBAC assignments.

Benefits include:

- Easier administration
- Consistent permissions
- Reduced human error
- Better auditing
- Supports organizational growth

---

# Design Decision 3

## Least Privilege Access

### Decision

Each department received access only to its own file share.

Examples:

Finance

- finance-files

HR

- hr-files

Marketing

- marketing-files

Operations

- operations-files

IT

- it-files

### Reason

Following the Principle of Least Privilege reduces the attack surface and prevents unauthorized access to sensitive business information.

---

# Design Decision 4

## Azure Private Endpoints

### Decision

Private Endpoints were deployed for both Storage Accounts.

Blob Storage

- pep-buystore-blob

Azure Files

- pep-buystore-file

### Reason

Private Endpoints allow storage traffic to remain on Microsoft's private backbone instead of traversing the public internet.

Benefits include:

- Improved security
- Private IP addressing
- Zero Trust networking
- Reduced exposure
- Simplified firewall configuration

---

# Design Decision 5

## Disable Public Network Access

### Decision

Public Network Access was disabled after validating Private Endpoint connectivity.

### Reason

Leaving storage publicly accessible increases the attack surface.

Disabling public access ensures all traffic originates from approved private networks.

---

# Design Decision 6

## Azure RBAC

### Decision

Role-Based Access Control was implemented using built-in Azure roles.

Examples include:

- Storage File Data SMB Share Contributor
- Storage File Data SMB Share Elevated Contributor

### Reason

Azure RBAC provides centralized authorization while avoiding shared credentials.

Benefits include:

- Centralized permission management
- Auditing
- Least privilege
- Easy maintenance

---

# Design Decision 7

## Geo-Redundant Storage (GRS)

### Decision

Both Storage Accounts use Geo-Redundant Storage.

### Reason

GRS replicates data to a secondary Azure region.

Benefits include:

- Disaster recovery
- Improved durability
- Regional resilience
- Business continuity

### Trade-off

GRS is more expensive than LRS but provides significantly higher availability for critical business data.

---

# Design Decision 8

## Blob Versioning

### Decision

Blob Versioning was enabled.

### Reason

Versioning protects against:

- Accidental overwrite
- Corruption
- Unwanted changes
- Recovery mistakes

Older versions remain recoverable without restoring backups.

---

# Design Decision 9

## Soft Delete

### Decision

Soft Delete was enabled for:

- Blob Storage
- Containers
- Azure File Shares

### Reason

Provides protection against accidental deletion while reducing recovery time.

---

# Design Decision 10

## Lifecycle Management

### Decision

Lifecycle policies were configured for long-term storage optimization.

Policies automatically:

- Move older data to cooler storage tiers
- Remove unnecessary versions
- Reduce storage costs

### Reason

Enterprise environments generate large volumes of data over time.

Automating data lifecycle reduces operational effort while lowering monthly Azure costs.

---

# Design Decision 11

## Resource Locks

### Decision

Delete Locks (CanNotDelete) were applied to both Storage Accounts.

### Reason

Critical production resources should never be accidentally deleted.

Resource Locks provide an additional governance layer beyond Azure RBAC.

---

# Design Decision 12

## Private DNS Zones

### Decision

Private DNS Zones were linked to the Virtual Network.

Zones:

- privatelink.blob.core.windows.net
- privatelink.file.core.windows.net

### Reason

Private DNS enables Azure resources inside the Virtual Network to automatically resolve storage account names to their private IP addresses.

Without Private DNS, applications would continue resolving the public endpoints, causing connectivity issues.

---

# Summary

The final architecture follows Microsoft's Well-Architected Framework by emphasizing:

- Security
- Reliability
- Operational Excellence
- Performance Efficiency
- Cost Optimization

The resulting solution provides a secure, scalable, resilient, and enterprise-ready Azure Storage platform suitable for modern business workloads.