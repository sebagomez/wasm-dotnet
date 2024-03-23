default:
  @just --list
  
kube_start:
	minikube start  --nodes 2 --container-runtime='containerd'
	kubectl annotate node minikube-m02 kwasm.sh/kwasm-node=true
	kubectl taint nodes minikube-m02 arch=wasm:NoSchedule --overwrite
	kubectl taint nodes minikube arch=x64:NoSchedule --overwrite

kwasm:
	helm repo add kwasm http://kwasm.sh/kwasm-operator/
	helm install -n kwasm --create-namespace kwasm-operator kwasm/kwasm-operator

clean:
	dotnet clean ./src/console/hello.csproj
	rm -rf ./src/console/obj
	rm -rf ./src/console/bin

build: build_x64

build_x64:
	dotnet build -c Release ./src/console/hello.csproj

run_x64:
	dotnet run -c Release --project ./src/console/hello.csproj

run_wasm:
	wasmtime ./src/console/bin/Release/net8.0/wasi-wasm/AppBundle/hello.wasm

build_wasm:
	dotnet build -c Release /p:RuntimeIdentifier=wasi-wasm /p:WasmSingleFileBundle=true ./src/console/hello.csproj

deploy_wasm:
	rm -rf ./bin/
	mkdir ./bin
	cp ./src/console/bin/Release/net8.0/wasi-wasm/AppBundle/hello.wasm ./bin

docker_build: build_wasm deploy_wasm
	docker buildx build -f ./docker/wasi.Dockerfile --platform wasi/wasm --provenance=false -t sebagomez/hello-wasm:wasi .
	docker build -f ./docker/dotnet.Dockerfile -t sebagomez/hello-wasm:dotnet .

docker_push:
	docker push sebagomez/hello-wasm:wasi
	docker push sebagomez/hello-wasm:dotnet

end:
	minikube delete