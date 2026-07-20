# Lessons Learned

## Azure uses system routes by default

Azure automatically creates routes between peered Virtual Networks.

To inspect traffic through Azure Firewall, these default routes must be overridden using User Defined Routes (UDRs).

---

## User Defined Routes take priority

When a UDR exists, Azure follows the custom route instead of the default system route.

---

## Azure Firewall only inspects traffic that reaches it

Deploying Azure Firewall alone does not secure traffic.

Traffic must be explicitly routed to the firewall.

---

## Windows Firewall can block successful Azure networking

Even after Azure networking was configured correctly, ICMP traffic failed.

The issue was caused by Windows Firewall blocking Echo Requests.

Enabling the ICMP Echo Request rule resolved the issue.

---

## Effective Routes are invaluable

Azure Network Watcher's Effective Routes confirmed that traffic was being forwarded to:

Virtual Appliance

10.0.1.4

instead of using Azure's default Internet route.

---

## Azure Bastion improves security

Using Azure Bastion eliminated the need for Public IP addresses on virtual machines while still allowing administrative access.

---

## Enterprise networking is layered

Security was achieved using multiple layers:

- Network Security Groups
- Azure Firewall
- Route Tables
- Bastion
- Windows Firewall

No single component provides complete protection.

