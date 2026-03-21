var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello from .NET Core 🚀");
app.MapGet("/add", (int a, int b) => a + b);

app.Run();
