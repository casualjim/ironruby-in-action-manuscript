using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CSharp
{
    class Program
    {
        static void Main(string[] args)
        {
           
            List<object> printables = new List<object> { new HelloWorld(), new Book("IronPython In Action") };

            printables.ForEach(printable => Output(printable as IPrintable));

            object hw = printables[0];
            Console.WriteLine("hw does {0}implement IPrintable", (hw is IPrintable) ? string.Empty : "not ");

        }

        static void Output(IPrintable toOutput)
        {
            Console.WriteLine(toOutput.Print());
        }
    }
}

