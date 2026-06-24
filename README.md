# Setup and Deployment Guide

## Prerequisites

Install the following tools on your local machine:

### 1. Install Terraform

Follow the official installation guide:

- https://developer.hashicorp.com/terraform/install

Verify installation:

```bash
terraform version
```

---

### 2. Install Docker

Follow the official installation guide:

- https://docs.docker.com/get-docker/

Verify installation:

```bash
docker --version
```

---

### 3. Install Minikube

Follow the official installation guide:

- https://minikube.sigs.k8s.io/docs/start/

Start Minikube:

```bash
minikube start
```

Verify installation:

```bash
minikube status
```

---

### 4. Install kubectl

Follow the official installation guide:

- https://kubernetes.io/docs/tasks/tools/

Verify installation:

```bash
kubectl version --client
```

---

## Clone the Repository

Clone the repository to your local machine:

```bash
git clone <repository-url>
cd <repository-name>
```

---

## Provision Infrastructure

Initialize Terraform:

```bash
terraform init
```

Review the execution plan:

```bash
terraform plan
```

Apply the configuration:

```bash
terraform apply
```

Confirm with:

```text
yes
```

---

# GitHub Branch Protection and CI Validation

## 1. Configure GitHub Actions

Ensure the repository contains a GitHub Actions workflow under:

```text
.github/workflows/
```

Example:

```text
.github/workflows/terraform.yml
```

The workflow should run validation, linting, tests, or deployment checks.

---

## 2. Enable Branch Protection

Navigate to:

```text
Repository Settings
→ Branches
→ Add Branch Protection Rule
```

Configure:

- Select the protected branch (typically `main`)
- Enable **Require a pull request before merging**
- Enable **Require status checks to pass before merging**
- Select the GitHub Actions workflow(s)
- Optionally enable:
  - Require approvals
  - Dismiss stale approvals
  - Restrict direct pushes

Save the rule.

---

## 3. Test Branch Protection

Create a feature branch:

```bash
git checkout -b test-pr
```

Make a small change:

```bash
echo "test" >> test.txt
git add .
git commit -m "Test PR"
git push origin test-pr
```

Create a Pull Request in GitHub.

Verify:

- GitHub Actions execute automatically
- Merge button is blocked if any checks fail
- Merge becomes available only after all checks pass

---

# Install Argo CD

## 1. Create Namespace

```bash
kubectl create namespace argocd
```

---

## 2. Install Argo CD

```bash
kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Verify installation:

```bash
kubectl get pods -n argocd
```

Wait until all pods are in the `Running` state.

---

# Access the Argo CD UI

## 1. Port Forward the Argo CD Server

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Leave this terminal window running.

---

## 2. Retrieve the Initial Admin Password

### Linux/macOS

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
```

### Windows PowerShell

```powershell
kubectl -n argocd get secret argocd-initial-admin-secret `
  -o jsonpath="{.data.password}"
```

Decode the resulting Base64 value.

---

## 3. Login to Argo CD

Open your browser:

```text
https://localhost:8080
```

Login with:

```text
Username: admin
Password: <password from previous step>
```

Accept the browser security warning if prompted.

---

# Deploy the Application Using Argo CD

Apply the Argo CD application manifest:

```bash
kubectl apply -f argocd-app.yaml
```

Verify deployment:

```bash
kubectl get applications -n argocd
```

You should see the application registered and syncing.

---

# Using a Private GitHub Repository

If the application manifests are stored in a private GitHub repository, Argo CD must be granted access.

## 1. Create a Personal Access Token (PAT)

In GitHub:

```text
Settings
→ Developer Settings
→ Personal Access Tokens
→ Tokens (Classic or Fine-grained)
→ Generate New Token
```

Grant at minimum:

```text
Contents: Read
Metadata: Read
```

Copy and securely store the generated token.

---

## 2. Add the Repository to Argo CD

In the Argo CD UI:

```text
Settings
→ Repositories
→ Connect Repo
```

Provide:

```text
Repository URL
GitHub Username
Personal Access Token
```

Click **Connect**.

---

# Useful Commands

Check cluster status:

```bash
kubectl cluster-info
```

View all namespaces:

```bash
kubectl get namespaces
```

View all pods:

```bash
kubectl get pods --all-namespaces
```

Check Argo CD pods:

```bash
kubectl get pods -n argocd
```

View applications managed by Argo CD:

```bash
kubectl get applications -n argocd
```

Stop Minikube:

```bash
minikube stop
```

Delete Minikube cluster:

```bash
minikube delete
```
