namespace lib;
public class Greet
{
	public static string SayHello(string? name)
	{
		if (name is null)
			name = "World";

		return $"Hello {name}!";
	}
}
