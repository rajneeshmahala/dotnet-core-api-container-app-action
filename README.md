# DemoApp — .NET 8 Web API

Demo project for the **Build + Docker CI** GitHub Actions pipeline.

## Project Structure

```
DemoApp.sln
├── DemoApp/                        # ASP.NET Core Web API
│   ├── Controllers/ddcdcdcgb
│   │   └── ProductsController.cs   # CRUD endpoints for /api/products
│   ├── Models/
│   │   └── Product.cs
│   ├── Program.csdfbfbd
│   ├── appsettings.json
│   └── DemoApp.csproj
├── DemoApp.Tests/                  # xUnit integration + unit tests
│   ├── ProductsApiTests.cs
│   └── DemoApp.Tests.csproj
├── Dockerfile                      # Multi-stage build (sdk → aspnet runtime)
├── .dockerignore
└── .github/
    └── workflows/
        └── build-docker-ci.yml     # CI pipeline
```

## API Endpoints

| Method | Route               | Description          |
|--------|---------------------|----------------------|
| GET    | `/api/products`     | List all products    |
| GET    | `/api/products/{id}`| Get product by ID    |
| POST   | `/api/products`     | Create a product     |
| PUT    | `/api/products/{id}`| Update a product     |
| DELETE | `/api/products/{id}`| Delete a product     |
| GET    | `/health`           | Health check         |
| GET    | `/swagger`          | Swagger UI           |

## Run Locally

```bash
cd DemoApp
dotnet run
# → https://localhost:5001/swagger
```

## Run Tests

```bash
dotnet test
```

## Build Docker Image

```bash
docker build -t demo-dotnet:1 .
docker run -p 8080:8080 demo-dotnet:1
# → http://localhost:8080/health
```

## Pipeline Steps

| Step               | Command                              |
|--------------------|--------------------------------------|
| Restore            | `dotnet restore`                     |
| Build              | `dotnet build --no-restore`          |
| Test               | `dotnet test --no-build`             |
| Publish            | `dotnet publish -c Release -o out`   |
| Docker build       | `docker build -t demo-dotnet:<run>`  |
| Trivy scan         | image scan, severity LOW, exit-code 0|

## Branch Convention

Push to `main` or any `wip/*` branch to trigger the pipeline.
