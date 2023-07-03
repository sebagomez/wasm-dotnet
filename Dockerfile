FROM scratch
COPY  ./bin/hello.wasm /hello.wasm
ENTRYPOINT [ "hello.wasm" ]

# docker buildx build --platform wasi/wasm32 -t sebagomez/hello-wasm -f Dockerfile .
# docker push sebagomez/webapi-wasm 

# docker run --rm --runtime=io.containerd.wasmtime.v1 --platform=wasi/wasm secondstate/rust-example-hello:latest