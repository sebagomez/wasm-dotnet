
start:
	minikube start
	bash <(curl https://raw.githubusercontent.com/krustlet/krustlet/main/scripts/bootstrap.sh)


clean:
	dotnet clean ./src/console/hello.csproj
	rm -rf ./src/console/obj
	rm -rf ./src/console/bin

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

end:
	minikube delete
