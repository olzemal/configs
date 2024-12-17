{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    docker-buildx
    k9s
    kind
    kubectl
    kubernetes-helm
    minikube
    trivy
  ];
}
