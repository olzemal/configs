{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    crossplane-cli
    docker-buildx
    grafana-loki
    k9s
    kind
    kubectl
    kubernetes-helm
    minikube
    talosctl
    trivy
    zarf
  ];
}
