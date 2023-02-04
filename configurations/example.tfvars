# Enable toggles
#enable_argo = false
#enable_metallb = false
#enable_traefik = false
#enable_externaldns = false

# Configuration for ArgoCD
argo_fqdn = "example.402.wtf"

# Configuration for MetalLB
metallb_ip_range = ["10.0.0.0/24"] # This is the IP range that MetalLB will use to allocate LoadBalancers or any other IP needed for a deployment

