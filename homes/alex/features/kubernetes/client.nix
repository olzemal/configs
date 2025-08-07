{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    crossplane-cli
    docker-buildx
    k9s
    kind
    kubectl
    kubernetes-helm
    minikube
    grafana-loki
    talosctl
    trivy
  ];
}
