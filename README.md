# ansible_windows

Replace all <> with your specific values.

## Inventory
Definition of the Vcenter inventory.
```bash
cat << 'EOF' > ./inventory/vcenter_vmware.yml
---
plugin: community.vmware.vmware_vm_inventory
strict: False
hostname: <vcenter_host>
username: <vcenter_user>
password: <vcenter_password>
validate_certs: False
with_tags: True
compose:
  # Example: Set the ansible_host var with IP that starts with 172.
  ansible_host: >-
    guest.net
    | selectattr('ipAddress')
    | map(attribute='ipAddress')
    | flatten
    | select('match', '^172.*')
    | list
    | first
properties:
  - config.name
  - config.guestId
  - guest.net
  - guest.guestFamily
groups:
  VMs: True
hostnames:
  - config.name
filters:
  - "'windows' in config.guestId"
EOF
```

## group_vars
Generic variables for VMs
```bash
cat << 'EOF' > ./group_vars/VMs.yml
---
ansible_user: <windows_user>
ansible_password: <windows_password>
ansible_connection: winrm
ansible_winrm_transport: ntlm
ansible_port: 5985
EOF
```

## group_vars
Example of local overrides for specific VMs if needed.
```bash
cat << 'EOF' > ./host_vars/<vm_name>.yml
---
ansible_port: 5986
ansible_winrm_server_cert_validation: ignore
EOF
```