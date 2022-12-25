
start:
	minikube start
	bash <(curl https://raw.githubusercontent.com/krustlet/krustlet/main/scripts/bootstrap.sh)

end:
	minikube delete
