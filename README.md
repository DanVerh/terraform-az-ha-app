# Description
This terraform code creates a simple VM with Nginx web app on it or two VMs with load balancing, if HA option is set to true.

# Simple architecture
- RG is created depending on value of boolean variable
- VNet, Subnet
- Public IP is created and associated with VM
- NIC and VM with user_data on it

# HA architecture
- RG is created depending on value of boolean variable
- VNet, Subnet
- Public IP is created and associated with frontend IP of LB
- Load Balancer with balancing rule and health probe on 80 port
- Two VMs with user_data on them and two NICs that are associated with LB backend pool

# How condition works here?
Condition here is configured with count meta-argument. Depending on boolean variable values we are specifying number of VMs and NICs, creation of LB and RG module, attachment of PIP and etc.

# Web app provisioning
Here it is performed with user_data bash script. But it is inside of the terraform template file, which allows using of dynamic values (f.e. here the name of the VM inside of html file)
