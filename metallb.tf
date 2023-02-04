resource "kubernetes_namespace" "metallb" {
  count = var.enable_metallb ? 1 : 0
  metadata {
    name = "metallb-system"
    labels = {
      "pod-security.kubernetes.io/audit" = "privileged"
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/warn" = "privileged"
    }
  }
}

resource "helm_release" "metallb" {
  count = var.enable_metallb ? 1 : 0
  depends_on = [kubernetes_namespace.metallb]
  name       = "metallb"
  chart      = "metallb"
  repository = "https://metallb.github.io/metallb"
  namespace  = kubernetes_namespace.metallb.metadata[0].name
  version    = "0.13.7"

}

resource "kubernetes_manifest" "metallb_pool" {
  count = var.enable_metallb ? 1 : 0
  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind"       = "IPAddressPool"
    "metadata" = {
      "name"      = "metallb-pool"
      "namespace" = kubernetes_namespace.metallb.metadata[0].name
    }
    "spec" = {
      "addresses" = var.metallb_ip_range
      autoAssign = true
    }
  }
}

resource "kubernetes_manifest" "metallb_l2_advert" {
  count = var.enable_metallb ? 1 : 0
  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind" = "L2Advertisement"
    metadata = {
      "name" = "l2adv"
      "namespace" = kubernetes_namespace.metallb.metadata[0].name
    }
  }
}
