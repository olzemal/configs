{ lib, pkgs, inputs, ... }:

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
    inputs.ocm.packages.${pkgs.system}.ocm
  ];
}
