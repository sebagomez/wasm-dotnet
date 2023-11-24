# syntax=docker/dockerfile:1
FROM scratch
COPY  ./bin/hello.wasm /hello.wasm
ENTRYPOINT [ "./hello.wasm" ]

# docker buildx build -f wasi.Dockerfile --platform wasi/wasm -t sebagomez/hello-wasm:wasi .

# docker run --runtime=io.containerd.wasmedge.v1 --platform=wasi/wasm sebagomez/hello-wasm:wasi
