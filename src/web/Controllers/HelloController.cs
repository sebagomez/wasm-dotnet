using Microsoft.AspNetCore.Mvc;

namespace web.Controllers;

[ApiController]
[Route("[controller]")]
public class HelloController : ControllerBase
{
    private readonly ILogger<HelloController> _logger;

    public HelloController(ILogger<HelloController> logger)
    {
        _logger = logger;
    }

    [HttpGet]
    public string Get(string? name)
    {
        if (string.IsNullOrEmpty(name))
			name = "World";

		return $"Hello {name}!";
    }
}
