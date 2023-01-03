FROM mcr.microsoft.com/dotnet/sdk:7.0 as builder

COPY ./src /src

RUN apt-get update && apt-get install libxml2

RUN dotnet restore /src/web/web.csproj && \
    dotnet build --configuration Release -p WASM=true --output /app /src/web/web.csproj 

FROM scratch AS export-stage
COPY --from=builder /app /

# docker build -o ./bin -f wasm.Dockerfile .