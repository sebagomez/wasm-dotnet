using lib;
using System.Runtime.InteropServices;

internal class Program
{
	private static void Main(string[] args)
	{
		string greeted = "World";
		if (args.Length != 0)
			greeted = string.Join(" ",args);

		Console.WriteLine($"{Greet.SayHello(greeted)} from {RuntimeInformation.OSArchitecture}!");
	}
}