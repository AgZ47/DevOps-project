# ============================================================
# main.tf — Local Kubernetes cluster with Minikube
# Provider: scott-the-programmers/minikube
# ============================================================

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "~> 0.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

# ----------------------------------------------------------
# Minikube provider — no credentials needed for local use
# ----------------------------------------------------------
provider "minikube" {
  kubernetes_version = var.kubernetes_version
}

# ----------------------------------------------------------
# Minikube cluster
# ----------------------------------------------------------
resource "minikube_cluster" "this" {
  cluster_name       = var.cluster_name
  driver             = var.driver # docker | virtualbox | hyperkit | none
  cpus               = var.cpus
  memory             = var.memory_mb # in MiB
  disk_size          = var.disk_size # e.g. "20000mb"
  kubernetes_version = var.kubernetes_version

  addons = var.addons
}

# ----------------------------------------------------------
# Kubernetes provider — wired up from minikube outputs
# ----------------------------------------------------------
provider "kubernetes" {
  host = minikube_cluster.this.host

  client_certificate     = minikube_cluster.this.client_certificate
  client_key             = minikube_cluster.this.client_key
  cluster_ca_certificate = minikube_cluster.this.cluster_ca_certificate
}

# ----------------------------------------------------------
# Sample namespace to verify the cluster is working
# ----------------------------------------------------------
resource "kubernetes_namespace" "app" {
  metadata {
    name = var.app_namespace
    labels = {
      managed-by  = "terraform"
      environment = "local"
    }
  }

  depends_on = [minikube_cluster.this]
}