variable "argo_fqdn" {
  description = "The FQDN that ArgoCD will be available on."
  type = string
  default = "example.402.wtf"
}

variable "metallb_ip_range" {
  description = "The IP range for which MetalLB can provision IP addresses."
  type = list(string)
  default = []
}
