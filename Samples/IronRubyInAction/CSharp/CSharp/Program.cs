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
    List<object> printables = new List<object>{ new HelloWorld(), new Book("IronPython In Action") };

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

/*
 *             if (args.Length == 0 || args[0] == "helloworld")
            {
                IPrintable printable = new HelloWorld();
                Console.WriteLine(printable.Print());
            }
            else
            {
                switch (args[0])
                {
                    case "statictyping":
                        StaticTyping.Demonstrate();
                        break;
                    case "typeinference":
                        TypeInference.Demonstrate();
                        break;
                    case "emit":
                        HelloWorldEmit.Demonstrate();
                        break;
                    case "lcg":
                        HelloWorldLCG.Demonstrate();
                        break;
                }
            }
*/
