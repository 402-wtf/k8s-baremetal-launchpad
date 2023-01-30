resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik" {
  depends_on = [kubernetes_namespace.traefik]
  name       = "traefik"
  chart      = "traefik"
  repository = "https://traefik.github.io/charts"
  namespace  = kubernetes_namespace.traefik.metadata[0].name
  version    = "20.8.0"

}
