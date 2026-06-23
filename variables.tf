# ============================================================
# variables.tf — Configurable knobs for the Minikube cluster
# ============================================================

variable "cluster_name" {
  description = "Name of the Minikube cluster."
  type        = string
  default     = "local-k8s"
}

variable "driver" {
  description = "Minikube driver to use (docker | virtualbox | hyperkit | none)."
  type        = string
  default     = "docker"

  validation {
    condition     = contains(["docker", "virtualbox", "hyperkit", "none"], var.driver)
    error_message = "Driver must be one of: docker, virtualbox, hyperkit, none."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version to install (e.g. 'v1.30.0')."
  type        = string
  default     = "v1.30.0"
}

variable "cpus" {
  description = "Number of CPUs to allocate to the cluster."
  type        = number
  default     = 2
}

variable "memory_mb" {
  description = "Amount of RAM in MiB to allocate to the cluster."
  type        = number
  default     = 4096
}

variable "disk_size" {
  description = "Disk size for the cluster (e.g. '20000mb')."
  type        = string
  default     = "20000mb"
}

variable "addons" {
  description = "List of Minikube addons to enable."
  type        = list(string)
  default = [
    "dashboard",
    "metrics-server",
    "ingress",
  ]
}

variable "app_namespace" {
  description = "Kubernetes namespace for sample workloads."
  type        = string
  default     = "app"
}
