# Design Decisions

## Why Hub-and-Spoke?

Instead of connecting every Virtual Network directly together, a Hub & Spoke topology was selected.

Advantages

- Centralized security
- Easier management
- Better scalability
- Reduced administrative overhead
- Lower long-term complexity

---

## Why Azure Firewall?

Azure Firewall provides centralized traffic inspection.

Benefits

- Single security point
- Future support for Application Rules
- Future support for Threat Intelligence
- Logging and monitoring
- Secure east-west traffic

---

## Why Azure Bastion?

Azure Bastion provides secure remote access to virtual machines without assigning Public IP addresses.

Benefits

- No RDP exposed to Internet
- No SSH exposed to Internet
- Reduced attack surface
- Browser-based management

---

## Why Route Tables?

Azure normally routes traffic directly between peered VNets.

User Defined Routes were created to override Azure's default routing so that all spoke traffic passes through Azure Firewall.

---

## Why Network Security Groups?

NSGs provide subnet level protection.

Each environment has its own NSG.

Benefits

- Separate security boundaries
- Least privilege
- Independent rule management
- Easier troubleshooting

---

## Why Separate VNets?

Each business environment is isolated.

Development

10.2.0.0/16

Production

10.1.0.0/16

Testing

10.3.0.0/16

Benefits

- Isolation
- Reduced blast radius
- Independent administration
- Easier future expansion

---

## Why Azure Network Watcher?

Azure Network Watcher provides diagnostics for:

- Effective Routes
- Next Hop
- NSG Diagnostics
- Connection Monitoring

It was used to validate routing after deployment.