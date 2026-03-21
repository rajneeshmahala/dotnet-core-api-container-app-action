# 🚀 .NET Core API + Docker + GitHub Actions

## Features
- .NET 8 Web API
- Docker multi-stage build
- GitHub Actions CI pipeline

## Run Locally
```
dotnet run
```

## API Endpoints
- `/` → Hello message
- `/add?a=2&b=3` → returns sum

## Docker
```
docker build -t demo-dotnet .
docker run -p 8080:80 demo-dotnet
```

## CI Pipeline
- Restore
- Build
- Publish
- Docker build
