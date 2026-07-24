# Deployment Guide

## Project

Enterprise Secure Storage Platform for Buystore

---

# Overview

This guide documents the deployment process for the Enterprise Secure Storage Platform built on Microsoft Azure. The implementation follows Azure best practices for security, networking, governance, identity, and storage management.

---

# Deployment Prerequisites

Before deployment, ensure the following requirements are met:

- Active Azure Subscription
- Owner or Contributor access to the subscription
- Microsoft Entra ID
- Azure Virtual Network
- Azure CLI or Azure Portal
- Appropriate Azure RBAC permissions

---

# Step 1 – Create Resource Group

Resource Group Name

```
rg-buystore-storage
```

Purpose

- Logical container for all project resources
- Simplifies resource management
- Enables centralized governance
- Supports lifecycle management

---

# Step 2 – Create Virtual Network

Virtual Network

```
vnet-buystore-storage
```

Address Space

```
10.40.0.0/16
```

Subnets

```
snet-private-endpoints
```

```
snet-management
```

Purpose

- Isolate network resources
- Support Private Endpoints
- Secure storage traffic

---

# Step 3 – Deploy Blob Storage Account

Storage Account

```
stbuystoredata001
```

Configuration

- General Purpose v2
- Standard Performance
- Geo-Redundant Storage (GRS)
- Secure Transfer Enabled
- Minimum TLS Version 1.2
- Public Access Disabled
- Blob Versioning Enabled
- Blob Soft Delete Enabled
- Container Soft Delete Enabled

---

# Step 4 – Deploy Azure Files Storage Account

Storage Account

```
stbuystorefiles001
```

Configuration

- General Purpose v2
- Standard Performance
- Geo-Redundant Storage (GRS)
- Secure Transfer Enabled
- Minimum TLS Version 1.2
- Public Access Disabled
- File Share Soft Delete Enabled

---

# Step 5 – Create Blob Containers

The following Blob Containers were created:

- application-backups
- company-documents
- finance-documents
- hr-records
- marketing-assets
- product-images

Purpose

Each container represents a separate business workload.

---

# Step 6 – Create Azure File Shares

The following Azure File Shares were created:

- finance-files
- hr-files
- marketing-files
- operations-files
- it-files

Purpose

Each department receives its own dedicated SMB file share.

---

# Step 7 – Configure Lifecycle Management

Lifecycle Policies Created

- application-backup-lifecycle
- marketing-assets-lifecycle
- product-images-lifecycle
- document-version-cleanup

Purpose

- Reduce storage costs
- Remove obsolete versions
- Automate data management

---

# Step 8 – Create Microsoft Entra Security Groups

Security Groups

- SG-Buystore-Finance
- SG-Buystore-HR
- SG-Buystore-Marketing
- SG-Buystore-Operations
- SG-Buystore-ITAdmins

Purpose

Permissions are assigned to groups rather than individual users.

---

# Step 9 – Configure Azure RBAC

Finance

Role

```
Storage File Data SMB Share Contributor
```

Scope

```
finance-files
```

---

HR

Role

```
Storage File Data SMB Share Contributor
```

Scope

```
hr-files
```

---

Marketing

Role

```
Storage File Data SMB Share Contributor
```

Scope

```
marketing-files
```

---

Operations

Role

```
Storage File Data SMB Share Contributor
```

Scope

```
operations-files
```

---

IT

Role

```
Storage File Data SMB Share Elevated Contributor
```

Scope

```
it-files
```

Purpose

Implement least privilege access for every department.

---

# Step 10 – Configure Private Endpoints

Blob Storage

Private Endpoint

```
pep-buystore-blob
```

Private IP

```
10.40.1.4
```

Private DNS Zone

```
privatelink.blob.core.windows.net
```

---

Azure Files

Private Endpoint

```
pep-buystore-file
```

Private IP

```
10.40.1.5
```

Private DNS Zone

```
privatelink.file.core.windows.net
```

Purpose

Ensure all storage traffic remains on Microsoft's private backbone.

---

# Step 11 – Disable Public Network Access

Public access was disabled only after:

- Private Endpoints were deployed
- Private DNS was configured
- Connectivity was validated

Purpose

Prevent internet access to storage resources.

---

# Step 12 – Configure Resource Locks

Lock Name

```
prevent-accidental-deletion
```

Lock Type

```
CanNotDelete
```

Applied To

- stbuystoredata001
- stbuystorefiles001

Purpose

Protect production resources from accidental deletion.

---

# Validation Checklist

The following validation steps were completed:

- Resource Group successfully deployed
- Virtual Network operational
- Blob Storage accessible through Private Endpoint
- Azure Files accessible through Private Endpoint
- Public Network Access disabled
- Microsoft Entra Security Groups created
- Azure RBAC assignments verified
- Lifecycle Policies enabled
- Resource Locks applied
- Blob Versioning enabled
- Soft Delete configured
- Geo-Redundant Storage enabled

---

# Final Architecture Summary

The completed solution includes:

- 1 Resource Group
- 1 Virtual Network
- 2 Subnets
- 2 Storage Accounts
- 6 Blob Containers
- 5 Azure File Shares
- 5 Microsoft Entra Security Groups
- 5 RBAC Assignments
- 2 Private Endpoints
- 2 Private DNS Zones
- 4 Lifecycle Policies
- 2 Resource Locks

---

# Deployment Outcome

The deployment successfully delivered a secure, enterprise-grade Azure Storage platform that aligns with Microsoft's Well-Architected Framework.

The environment provides:

- Private connectivity
- Secure identity management
- Department-based authorization
- Automated lifecycle management
- Disaster recovery capabilities
- Governance controls
- Enterprise-ready storage architecture