# ============================================================
# outputs.tf — Useful values after `terraform apply`
# ============================================================

output "cluster_name" {
  description = "Name of the Minikube cluster."
  value       = minikube_cluster.this.cluster_name
}

output "kubernetes_host" {
  description = "API server endpoint of the cluster."
  value       = minikube_cluster.this.host
}

output "client_certificate" {
  description = "Client certificate for kubectl authentication."
  value       = minikube_cluster.this.client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client private key for kubectl authentication."
  value       = minikube_cluster.this.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA certificate."
  value       = minikube_cluster.this.cluster_ca_certificate
  sensitive   = true
}

output "app_namespace" {
  description = "Namespace where sample workloads are deployed."
  value       = kubernetes_namespace.app.metadata[0].name
}

output "kubectl_context_command" {
  description = "Command to switch kubectl context to this cluster."
  value       = "kubectl config use-context ${var.cluster_name}"
}

output "dashboard_command" {
  description = "Command to open the Kubernetes dashboard (if addon is enabled)."
  value       = "minikube dashboard --profile ${var.cluster_name}"
}
