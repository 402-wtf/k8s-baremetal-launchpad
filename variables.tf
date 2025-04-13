variable "argo_fqdn" {
  description = "The FQDN that ArgoCD will be available on."
  type        = string
  default     = "example.402.wtf"
}

variable "metallb_ip_range" {
  description = "The IP range for which MetalLB can provision IP addresses."
  type        = list(string)
  default     = []
}

variable "enable_argo" {
  description = "Boolean to install ArgoCD or not. Defaults to True."
  type        = bool
  default     = true
}

variable "enable_metallb" {
  description = "Boolean to install MetalLB or not. Defaults to True."
  type        = bool
  default     = true
}

variable "enable_traefik" {
  description = "Boolean to install Traefik or not. Defaults to True."
  type        = bool
  default     = true
}

variable "enable_externaldns" {
  description = "Boolean to install ExternalDNS or not. Defaults to True."
  type        = bool
  default     = true
}


