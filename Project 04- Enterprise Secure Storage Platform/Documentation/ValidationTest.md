# Validation Tests

## Project

Enterprise Secure Storage Platform for Buystore

---

# Overview

This document records the validation tests performed after deploying the Enterprise Secure Storage Platform.

The objective was to verify that all deployed Azure resources functioned as expected and met the project's security, networking, identity, governance, and storage requirements.

---

# Test 1 – Resource Deployment

## Objective

Verify that all Azure resources were successfully deployed.

### Validation Steps

- Open Azure Portal.
- Navigate to the Resource Group.
- Confirm all expected resources exist.

### Expected Result

All planned resources are successfully deployed.

### Status

✅ Passed

---

# Test 2 – Blob Storage Account

## Objective

Verify that the Blob Storage Account is operational.

### Validation Steps

- Open Storage Account.
- Browse Blob Containers.
- Verify all containers exist.

### Expected Result

All Blob Containers are available.

### Containers Verified

- application-backups
- company-documents
- finance-documents
- hr-records
- marketing-assets
- product-images

### Status

✅ Passed

---

# Test 3 – Azure File Shares

## Objective

Verify Azure File Shares were created successfully.

### Validation Steps

- Open Azure Files.
- Navigate to File Shares.
- Confirm all departmental shares exist.

### Expected Result

Five departmental shares are available.

### Shares Verified

- finance-files
- hr-files
- marketing-files
- operations-files
- it-files

### Status

✅ Passed

---

# Test 4 – Blob Versioning

## Objective

Verify Blob Versioning is enabled.

### Validation Steps

- Open Data Protection.
- Confirm Versioning is enabled.

### Expected Result

Blob Versioning displays as Enabled.

### Status

✅ Passed

---

# Test 5 – Blob Soft Delete

## Objective

Verify Blob Soft Delete is enabled.

### Validation Steps

- Navigate to Data Protection.
- Review Blob Soft Delete settings.

### Expected Result

Blob Soft Delete is enabled.

### Status

✅ Passed

---

# Test 6 – Container Soft Delete

## Objective

Verify Container Soft Delete is enabled.

### Validation Steps

- Open Data Protection.
- Confirm Container Soft Delete is enabled.

### Expected Result

Container recovery is available.

### Status

✅ Passed

---

# Test 7 – Azure File Share Soft Delete

## Objective

Verify File Share Soft Delete is enabled.

### Validation Steps

- Navigate to Data Protection.
- Confirm File Share Soft Delete is enabled.

### Expected Result

Deleted file shares can be recovered within the configured retention period.

### Status

✅ Passed

---

# Test 8 – Lifecycle Management

## Objective

Verify Lifecycle Management policies are active.

### Validation Steps

- Open Lifecycle Management.
- Review all configured policies.

### Policies Verified

- application-backup-lifecycle
- marketing-assets-lifecycle
- product-images-lifecycle
- document-version-cleanup

### Expected Result

All lifecycle policies are enabled.

### Status

✅ Passed

---

# Test 9 – Microsoft Entra Security Groups

## Objective

Verify security groups were successfully created.

### Validation Steps

- Open Microsoft Entra ID.
- Navigate to Groups.

### Groups Verified

- SG-Buystore-Finance
- SG-Buystore-HR
- SG-Buystore-Marketing
- SG-Buystore-Operations
- SG-Buystore-ITAdmins

### Expected Result

All security groups exist.

### Status

✅ Passed

---

# Test 10 – Azure RBAC

## Objective

Verify department permissions were assigned correctly.

### Validation Steps

- Open each Azure File Share.
- Review Access Control (IAM).
- Verify role assignments.

### Expected Result

Each department has access only to its assigned file share.

### Status

✅ Passed

---

# Test 11 – Private Endpoint (Blob Storage)

## Objective

Verify Blob Storage uses Private Endpoint connectivity.

### Validation Steps

- Open Storage Account.
- Navigate to Networking.
- Review Private Endpoint Connections.

### Expected Result

Private Endpoint status is Approved.

### Endpoint

pep-buystore-blob

Private IP

10.40.1.4

### Status

✅ Passed

---

# Test 12 – Private Endpoint (Azure Files)

## Objective

Verify Azure Files uses Private Endpoint connectivity.

### Validation Steps

- Open Storage Account.
- Review Private Endpoint Connections.

### Expected Result

Private Endpoint status is Approved.

### Endpoint

pep-buystore-file

Private IP

10.40.1.5

### Status

✅ Passed

---

# Test 13 – Public Network Access

## Objective

Ensure Storage Accounts are not publicly accessible.

### Validation Steps

- Open Networking.
- Review Public Network Access configuration.

### Expected Result

Public Network Access is Disabled.

### Status

✅ Passed

---

# Test 14 – Private DNS

## Objective

Verify Private DNS Zones are correctly linked.

### Validation Steps

- Open Private DNS Zones.
- Review Virtual Network Links.

### Zones Verified

- privatelink.blob.core.windows.net
- privatelink.file.core.windows.net

### Expected Result

Storage account names resolve to private IP addresses.

### Status

✅ Passed

---

# Test 15 – Geo-Redundant Storage

## Objective

Verify storage replication configuration.

### Validation Steps

- Open Storage Account.
- Review Replication settings.

### Expected Result

Replication type displays as Geo-Redundant Storage (GRS).

### Status

✅ Passed

---

# Test 16 – Resource Locks

## Objective

Verify accidental deletion protection.

### Validation Steps

- Open Storage Account.
- Navigate to Locks.

### Expected Result

Delete Lock (CanNotDelete) is present.

### Lock Verified

prevent-accidental-deletion

### Status

✅ Passed

---

# Validation Summary

| Test | Result |
|-------|--------|
| Resource Deployment | ✅ Passed |
| Blob Storage | ✅ Passed |
| Azure Files | ✅ Passed |
| Blob Versioning | ✅ Passed |
| Blob Soft Delete | ✅ Passed |
| Container Soft Delete | ✅ Passed |
| File Share Soft Delete | ✅ Passed |
| Lifecycle Management | ✅ Passed |
| Microsoft Entra Security Groups | ✅ Passed |
| Azure RBAC | ✅ Passed |
| Blob Private Endpoint | ✅ Passed |
| Azure Files Private Endpoint | ✅ Passed |
| Public Network Access Disabled | ✅ Passed |
| Private DNS | ✅ Passed |
| Geo-Redundant Storage | ✅ Passed |
| Resource Locks | ✅ Passed |

---

# Conclusion

All planned validation tests were successfully completed.

The deployed solution meets the project's security, networking, governance, identity, and operational requirements. The environment is functioning as designed and aligns with Microsoft Azure best practices for an enterprise storage platform.