using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
           
//            List<object> printables = new List<object> { new HelloWorld(), new Book("IronPython In Action") };
//
//            printables.ForEach(printable => Output(printable as IPrintable));
//
//            object hw = printables[0];
//            Console.WriteLine("hw does {0}implement IPrintable", (hw is IPrintable) ? string.Empty : "not ");

            for (int i = 0; i <= 45; i++)
            {
                Stopwatch sw = Stopwatch.StartNew();
                int fib = Fibonacci.WithoutRecursion(i);
                sw.Stop();
                
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine("Looped Fibonacci({0}) = {1:###,###,###,##0} [{2:0.###} ticks]", i, fib, sw.ElapsedTicks);//((float)sw.ElapsedMilliseconds / 1000));

                sw.Reset();
                sw.Start();
                int fibRec = Fibonacci.WithRecursion(i);
                sw.Stop();

                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("Recursive Fibonacci({0}) = {1:###,###,###,##0} [{2:0.###} seconds]", i, fibRec, ((float)sw.ElapsedMilliseconds / 1000));

            }
            Console.ResetColor();
            Console.Write("Press any key to exit...");
            Console.ReadKey();

        }

        static void Output(IPrintable toOutput)
        {
            Console.WriteLine(toOutput.Print());
        }
    }
}

