FROM mcr.microsoft.com/dotnet/sdk:7.0 as builder

WORKDIR /src
COPY ./web /src

RUN dotnet publish --configuration Release -o ./bin ./web.csproj


