**Prompt**

write a simple terraform script to setup a local kubernetes cluster using minikube.

**Fixes**

1. Moved all hardcoded values into variables that can be edited easily
2. Removed kubernetes deployment scripts as it would be a part of ArgoCD
