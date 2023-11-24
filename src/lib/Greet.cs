namespace lib;
public class Greet
{
	public static string SayHello(string? name)
	{
		name ??= "World";

		return $"Hello {name}";
	}
}
