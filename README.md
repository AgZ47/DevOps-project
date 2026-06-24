How to setup and run

1. install terraform
2. install minikube
3. install kubectl
4. pull this repo
5. run terraform init, terraform plan, terraform apply

6. setup the github actions check
7. enable branch protection to prevent pull request from merging incase any of the checks failed

8. install ArgoCD on minikube using "kubectl create namespace argocd" and "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
9. port forward argocd server to localhost to view UI "kubectl port-forward svc/argocd-server -n argocd 8080:443" and "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d"
10. go to browser open localhost:8080, login with username: admin and password received from the previous command
11. apply argocd-app.yaml file to the cluster using "kubectl apply -f argocd-app.yaml"

12. if running with private repository create a presonal access token in github setup your repository within the argocd UI
