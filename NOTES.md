**Prompt Used:**

> "Write a simple terraform script to set up a local Kubernetes cluster using minikube."

**The "Catch" / Manual Corrections Made:**
I reviewed the AI-generated code and made several manual architectural and security corrections to align with production best practices:

1. **Architectural Realignment (GitOps Strictness):** The AI originally included Kubernetes `Deployment` and `Service` resources inside the Terraform script. I manually removed these. Terraform's responsibility was strictly limited to infrastructure provisioning, delegating the application deployment entirely to ArgoCD.

2. **Variable Extraction:** The AI hardcoded values directly into `main.tf`. I refactored the code, extracting these into a `variables.tf` file to make the infrastructure modular and reusable.
