resource "kubernetes_namespace" "argocd" {
  count = var.enable_argo ? 1 : 0
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  count = var.enable_argo ? 1 : 0
  depends_on = [kubernetes_namespace.argocd]
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
  version    = "5.19.12"
  timeout    = 600

  set {
    name  = "server.service.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = var.argo_fqdn
  }

  set {
    name  = "redis-ha.enabled"
    value = "true"
  }

  set {
    name  = "controller.replicas"
    value = "1"
  }

  set {
    name  = "server.autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "server.autoscaling.minReplicas"
    value = "2"
  }

  set {
    name  = "repoServer.autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "repoServer.autoscaling.minReplicas"
    value = "2"
  }

  set {
    name  = "applicationSet.replicaCount"
    value = "2"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

}
