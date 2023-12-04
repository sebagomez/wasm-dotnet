# Originally from https://kwasm.sh/quickstart/
minikube start  --nodes 2 --container-runtime='containerd'

helm repo add kwasm http://kwasm.sh/kwasm-operator/
helm install -n kwasm --create-namespace kwasm-operator kwasm/kwasm-operator

kubectl annotate node minikube-m02 kwasm.sh/kwasm-node=true

kubectl taint nodes minikube-m02 arch=wasm:NoSchedule
kubectl taint nodes minikube arch=x64:NoSchedule
