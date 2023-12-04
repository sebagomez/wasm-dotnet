FROM mcr.microsoft.com/dotnet/sdk:8.0 as builder

COPY ./src /src

RUN dotnet publish -c Release -o /app  ./src/console/hello.csproj 

FROM mcr.microsoft.com/dotnet/runtime:8.0 as runtime
COPY --from=builder /app /app
WORKDIR /app
ENTRYPOINT ["dotnet", "hello.dll"]

# docker build -f ./docker/dotnet.Dockerfile -t sebagomez/hello-wasm:dotnet .
# docker run --rm sebagomez/hello-wasm:dotnet
# docker push sebagomez/hello-wasm:dotnet