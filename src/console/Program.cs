using lib;
using System.Runtime.InteropServices;

internal class Program
{
	private static void Main(string[] args)
	{
		string greeted = "World";

		if (args.Length != 0)
		{
			if (args.Length == 1)
			{
				int to;
				if (int.TryParse(args[0], out to))
				{
					Console.WriteLine($"{Util.CalculateFibonacci(to)} in {RuntimeInformation.OSArchitecture}!");
					return;
				}
				else
					greeted = string.Join(" ", args);
			}
		}

		Console.WriteLine($"{Util.SayHello(greeted)} from {RuntimeInformation.OSArchitecture}!");
	}
}