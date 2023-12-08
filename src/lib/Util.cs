namespace lib;
public class Util
{
	public static string SayHello(string? name)
	{
		name ??= "World";

		return $"Hello {name}";
	}

	public static string CalculateFibonacci(int to)
	{
		TimeSpan startTimeSpan = TimeSpan.FromTicks(DateTime.Now.Ticks);

		long value = Fibonacci(to);
		
		TimeSpan endTimeSpan = TimeSpan.FromTicks(DateTime.Now.Ticks);

		TimeSpan result = endTimeSpan - startTimeSpan;

		return string.Format($"It took {result.Hours.ToString("00")}:{result.Minutes.ToString("00")}:{result.Seconds.ToString("00")}:{result.Milliseconds.ToString("00")} to calculate the {to}th Fibonacci number ({value})");
	}

	static long Fibonacci(int n)
    {
        if (n <= 0)
        {
            return 0;
        }
        else if (n == 1)
        {
            return 1;
        }
        else
        {
            return Fibonacci(n - 1) + Fibonacci(n - 2);
        }
    }
}
