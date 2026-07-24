# Enterprise Azure Architecture Diagram

```text
                                        Internet
                                            │
                                            │
                              (Public Network Access Disabled)
                                            │
                                            ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│                                  Microsoft Azure Subscription                               │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
                                            │
                                            ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│                              Resource Group: rg-buystore-storage                            │
└──────────────────────────────────────────────────────────────────────────────────────────────┘
                                            │
                                            ▼
┌──────────────────────────────────────────────────────────────────────────────────────────────┐
│                          Virtual Network: vnet-buystore-storage                             │
│                                   Address Space: 10.40.0.0/16                              │
│                                                                                              │
│  ┌──────────────────────────────┐          ┌──────────────────────────────┐                  │
│  │ Management Subnet            │          │ Private Endpoint Subnet      │                  │
│  │ snet-management              │          │ snet-private-endpoints       │                  │
│  └──────────────────────────────┘          └──────────────────────────────┘                  │
│                                                        │                                     │
│                                      ┌─────────────────┴─────────────────┐                   │
│                                      │                                   │                   │
│                                      ▼                                   ▼                   │
│                         Private Endpoint                    Private Endpoint                  │
│                         pep-buystore-blob                  pep-buystore-file                 │
│                           10.40.1.4                           10.40.1.5                      │
│                                      │                                   │                   │
└──────────────────────────────────────┼───────────────────────────────────┼───────────────────┘
                                       │                                   │
                                       ▼                                   ▼
                  ┌────────────────────────────────┐     ┌────────────────────────────────┐
                  │ Azure Blob Storage             │     │ Azure Files Storage            │
                  │ stbuystoredata001             │     │ stbuystorefiles001            │
                  │                                │     │                                │
                  │ Replication: GRS              │     │ Replication: GRS              │
                  │ Versioning Enabled            │     │ File Share Soft Delete        │
                  │ Blob Soft Delete              │     │ Public Access Disabled        │
                  │ Container Soft Delete         │     │ Resource Lock                 │
                  │ Lifecycle Policies            │     │                                │
                  │ Public Access Disabled        │     │                                │
                  │ Resource Lock                 │     │                                │
                  └──────────────┬─────────────────┘     └──────────────┬─────────────────┘
                                 │                                      │
             ┌───────────────────┼──────────────────┐         ┌─────────┼───────────────┐
             │                   │                  │         │         │               │
             ▼                   ▼                  ▼         ▼         ▼               ▼

     application-backups   company-documents   finance-documents   finance-files   hr-files

             ▼                   ▼                  ▼                 ▼             ▼

        marketing-assets      hr-records      product-images   marketing-files operations-files

                                                                     ▼
                                                                it-files

────────────────────────────────────────────────────────────────────────────────────────────────

                              Microsoft Entra ID (Azure AD)
                                          │
                                          ▼
                          Microsoft Entra Security Groups

                      SG-Buystore-Finance
                      SG-Buystore-HR
                      SG-Buystore-Marketing
                      SG-Buystore-Operations
                      SG-Buystore-ITAdmins
                                          │
                                          ▼
                           Azure Role-Based Access Control
                                          │
      ┌───────────────────────┬───────────────────────┬───────────────────────┐
      │                       │                       │                       │
      ▼                       ▼                       ▼                       ▼

Finance Group          HR Group             Marketing Group        Operations Group
Storage File Data      Storage File Data    Storage File Data      Storage File Data
SMB Share              SMB Share            SMB Share              SMB Share
Contributor            Contributor          Contributor            Contributor

                                          │
                                          ▼

                                  IT Administrators

                    Storage File Data SMB Share Elevated Contributor

────────────────────────────────────────────────────────────────────────────────────────────────

Security Controls

✔ Private Endpoints
✔ Private DNS Zones
✔ Public Network Access Disabled
✔ Microsoft Entra ID Authentication
✔ Azure RBAC
✔ Least Privilege Access
✔ TLS 1.2 Enforcement
✔ Secure Transfer Required

────────────────────────────────────────────────────────────────────────────────────────────────

Data Protection

✔ Blob Versioning
✔ Blob Soft Delete
✔ Container Soft Delete
✔ File Share Soft Delete
✔ Geo-Redundant Storage (GRS)
✔ Azure Backup
✔ Resource Locks

────────────────────────────────────────────────────────────────────────────────────────────────

Governance & Cost Optimization

✔ Lifecycle Management Policies
✔ Resource Tags
✔ CanNotDelete Resource Locks
✔ Automatic Version Cleanup
✔ Cool Tier Transition
✔ Enterprise Storage Architecture
```