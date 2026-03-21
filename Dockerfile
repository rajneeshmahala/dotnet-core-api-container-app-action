# ── Stage 1: Build ──────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution + project files first (layer cache for restore)
COPY DemoApp.sln                        ./
COPY DemoApp/DemoApp.csproj             DemoApp/
COPY DemoApp.Tests/DemoApp.Tests.csproj DemoApp.Tests/

RUN dotnet restore

# Copy source and build
COPY DemoApp/     DemoApp/
RUN dotnet build  DemoApp/DemoApp.csproj -c Release --no-restore

# Publish
RUN dotnet publish DemoApp/DemoApp.csproj -c Release -o /app/out --no-build

# ── Stage 2: Runtime ────────────────────────────────────────────
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Non-root user for security
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

COPY --from=build /app/out .

# Port the app listens on
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1

ENTRYPOINT ["dotnet", "DemoApp.dll"]
