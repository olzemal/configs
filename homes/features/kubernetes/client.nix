{ lib, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    crossplane-cli
    docker-buildx
    fluxcd
    grafana-loki
    k9s
    kind
    kubectl
    kubernetes-helm
    minikube
    talosctl
    trivy

    inputs.ocm.packages.${pkgs.system}.ocm
  ];
}
