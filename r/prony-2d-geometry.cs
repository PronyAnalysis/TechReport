using System;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;

public class Program
{
    public static void Main(string[] args)
    {
        var h = args.Length == 0 ? 0.1 : double.Parse(args[0], CultureInfo.InvariantCulture);
        var sw = Stopwatch.StartNew();
        var builder = new StringBuilder();
        builder.AppendLine("x;y;value");
        Calc(builder, h);
        File.WriteAllText("data.csv", builder.ToString());
        sw.Stop();
        Console.WriteLine($"Done, TotalTime = {sw.ElapsedMilliseconds} ms");
    }

    private static void Calc(StringBuilder builder, double h)
    {
        double[] xs = Seq(-h, h, 501), ys = Seq(0, 2 * h, 501), das = Seq(-0.01, 0.01, 51);
        double refm1 = h, refm2 = h * h, refm3 = h * h * h;
        foreach (var x in xs)
            foreach (var y in ys)
            {
                var best = 1e100;
                var a0 = 2 - Clamp(Math.Abs(x - y) < 1e-9 ? 0 : (h - 2 * x) / (y - x), 0, 2);
                foreach (var da in das)
                {
                    var a = Clamp(a0 + da, 0, 2);
                    var b = 2 - a;
                    var m1 = a * x + b * y;
                    var m2 = a * x * x + b * y * y;
                    var m3 = a * x * x * x + b * y * y * y;
                    var d = Sqr(refm1 - m1) + Sqr(refm2 - m2) + Sqr(refm3 - m3);
                    best = Math.Min(d, best);
                }
                builder.AppendLine($"{x:0.0000};{y:0.0000};{Math.Sqrt(best):0.0000}");
            }
    }

    private static double[] Seq(double from, double to, double length) =>
        Enumerable.Range(0, (int)length).Select(i => @from + (to - @from) / ((int)length - 1) * i).ToArray();

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static double Sqr(double value) => value * value;

    [MethodImpl(MethodImplOptions.AggressiveInlining)]
    public static double Clamp(double value, double min, double max) => Math.Min(max, Math.Max(min, value));
}