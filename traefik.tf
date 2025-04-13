resource "kubernetes_namespace" "traefik" {
  count = var.enable_traefik ? 1 : 0
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik" {
  count = var.enable_traefik ? 1 : 0
  depends_on = [kubernetes_namespace.traefik]
  name       = "traefik"
  chart      = "traefik"
  repository = "https://traefik.github.io/charts"
  namespace  = kubernetes_namespace.traefik[0].metadata[0].name
  version    = "35.0.0"

}
