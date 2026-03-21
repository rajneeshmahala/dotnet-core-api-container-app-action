# Demo .NET Core CI/CD Project

## Features
- .NET 8 Web API
- Docker support
- GitHub Actions CI pipeline

## Run locally
```
dotnet run
```

## Docker
```
docker build -t demo-dotnet .
docker run -p 8080:80 demo-dotnet
```

## Pipeline
- Restore
- Build
- Publish
- Docker build
