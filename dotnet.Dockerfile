FROM mcr.microsoft.com/dotnet/sdk:7.0 as builder

COPY ./src /src

RUN dotnet restore /src/web/web.csproj && \
    dotnet build --configuration Release --output /app /src/web/web.csproj 

FROM mcr.microsoft.com/dotnet/aspnet:7.0 as runtime
COPY --from=builder /app /app
WORKDIR /app
ENTRYPOINT ["dotnet", "web.dll"]

# docker build -f dotnet.Dockerfile -t sebagomez/webapi-dll .
# docker push sebagomez/webapi-dll