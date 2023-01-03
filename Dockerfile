# syntax=docker/dockerfile:1
FROM scratch
COPY  ./bin/web.wasm /web.wasm
ENTRYPOINT [ "/web.wasm" ]

# docker buildx build --platform wasi/wasm32 -t sebagomez/webapi-wasm -f Dockerfile .
# docker push sebagomez/webapi-wasm 