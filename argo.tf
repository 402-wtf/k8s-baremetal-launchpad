resource "kubernetes_namespace" "argocd" {
  count = var.enable_argo ? 1 : 0
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  count      = var.enable_argo ? 1 : 0
  depends_on = [kubernetes_namespace.argocd]
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"
  version    = "7.8.23"
  timeout    = 600

  set = [
    {
      name  = "server.service.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
      value = var.argo_fqdn
    },
    {
      name  = "redis-ha.enabled"
      value = "true"
    },
    {
      name  = "controller.replicas"
      value = "1"
    },
    {
      name  = "server.autoscaling.enabled"
      value = "true"
    },

    {
      name  = "server.autoscaling.minReplicas"
      value = "2"
    },

    {
      name  = "repoServer.autoscaling.enabled"
      value = "true"
    },

    {
      name  = "repoServer.autoscaling.minReplicas"
      value = "2"
    },

    {
      name  = "applicationSet.replicaCount"
      value = "2"
    },

    {
      name  = "configs.params.server\\.insecure"
      value = "true"
    },
  ]
}
