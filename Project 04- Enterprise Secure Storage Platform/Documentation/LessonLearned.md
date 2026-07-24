# Lessons Learned

## Project

Enterprise Secure Storage Platform for Buystore

---

# Overview

This project provided practical experience in designing and deploying a secure, enterprise-grade Azure Storage solution. Beyond provisioning resources, it reinforced the importance of architectural planning, security, governance, networking, and operational best practices.

The following are the key lessons learned throughout the implementation.

---

# Lesson 1

## Storage Architecture Matters

Initially, it seemed possible to host both Blob Storage and Azure Files within a single Storage Account.

However, separating workloads into dedicated Storage Accounts proved to be a better architectural decision because it provides:

- Better workload isolation
- Simpler administration
- Easier access management
- Independent lifecycle policies
- Improved scalability

This reflects how enterprise environments are commonly designed.

---

# Lesson 2

## Identity Should Be Group-Based

Rather than assigning permissions directly to individual users, Microsoft Entra Security Groups were used.

This approach makes permission management significantly easier because:

- New employees only need to be added to a group.
- Employees who leave can simply be removed from the group.
- RBAC assignments remain unchanged.

This reduces administrative effort and minimizes human error.

---

# Lesson 3

## Understand Management Plane vs Data Plane

One of the most important lessons from this project was understanding the difference between Azure's Management Plane and Data Plane.

Management Plane controls Azure resources themselves, such as:

- Storage Accounts
- Networking
- Configuration
- Resource settings

Data Plane controls access to the actual files and data stored within those resources.

For example:

- **Storage Account Contributor** manages the Storage Account configuration but does not grant access to files.
- **Storage File Data SMB Share Contributor** grants access to the file share contents without allowing changes to the Storage Account configuration.

Understanding this distinction is essential when implementing secure RBAC.

---

# Lesson 4

## Private Endpoints Require Private DNS

Deploying a Private Endpoint alone is not sufficient.

Azure resources also require Private DNS Zones so that storage account names resolve to private IP addresses instead of public endpoints.

Without Private DNS:

- Name resolution fails.
- Applications attempt to use the public endpoint.
- Private connectivity does not function correctly.

Networking and DNS are closely connected in Azure.

---

# Lesson 5

## Disable Public Access Only After Validation

A critical operational lesson was the importance of deployment order.

The correct sequence is:

1. Deploy Private Endpoint.
2. Configure Private DNS.
3. Validate connectivity.
4. Disable Public Network Access.

Following this order prevents accidental service outages during deployment.

---

# Lesson 6

## Lifecycle Policies Reduce Operational Work

Lifecycle Management automates storage optimization by moving older data to lower-cost tiers and removing unnecessary versions.

Instead of manually managing storage growth, Azure handles these tasks automatically.

Benefits include:

- Lower storage costs
- Reduced administrative effort
- Consistent data management

---

# Lesson 7

## Resource Locks Are an Operational Safeguard

RBAC controls who can perform actions.

Resource Locks protect resources from accidental deletion—even by users with high levels of access.

Applying a **CanNotDelete** lock adds an additional layer of operational protection.

---

# Lesson 8

## Geo-Redundant Storage Improves Resilience

Choosing Geo-Redundant Storage (GRS) increases resilience by maintaining replicated copies of data in a secondary Azure region.

Although GRS costs more than Local Redundant Storage (LRS), it provides greater durability and supports business continuity objectives.

---

# Lesson 9

## Least Privilege Improves Security

Each department received access only to its own Azure File Share.

Restricting permissions in this way reduces the attack surface and limits the impact of compromised accounts.

Least Privilege is a fundamental security principle for enterprise environments.

---

# Lesson 10

## Enterprise Projects Require Governance

Building infrastructure is only part of a successful Azure deployment.

Governance features such as:

- Resource Tags
- Resource Locks
- RBAC
- Lifecycle Policies

are essential for managing production environments effectively.

Governance should be incorporated from the beginning of every deployment.

---

# Challenges Encountered

Several challenges were encountered during the project, including:

- Understanding the difference between Management Plane and Data Plane permissions.
- Selecting the correct RBAC roles for Azure Files.
- Configuring Private Endpoints and Private DNS together.
- Determining the correct deployment order before disabling Public Network Access.
- Understanding Provisioned v2 Azure File Share sizing.
- Designing a scalable enterprise storage architecture rather than a basic lab environment.

Resolving these challenges improved both technical knowledge and architectural decision-making.

---

# Key Takeaways

This project strengthened practical experience in:

- Azure Storage
- Azure Networking
- Microsoft Entra ID
- Azure RBAC
- Azure Private Link
- Azure DNS
- Azure Governance
- Disaster Recovery
- Cost Optimization
- Enterprise Architecture

More importantly, it reinforced the value of planning infrastructure before deployment and making design decisions based on security, scalability, and operational requirements rather than simply provisioning resources.

---

# Conclusion

The Enterprise Secure Storage Platform successfully demonstrates how Azure Storage services can be combined with identity management, private networking, governance, and lifecycle management to create a secure, scalable, and production-ready storage solution.

The knowledge gained from this project provides a strong foundation for future Azure architecture, administration, and cloud engineering projects.