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
            if(args.Length == 0 || args[0] == "helloworld")
                Console.WriteLine(new HelloWorld().Print());
            else
            {
                switch(args[0])
                {
                    case "statictyping":
                        StaticTyping.Demonstrate();
                        break;
                    case "typeinference":
                        TypeInference.Demonstrate();
                        break;
                }
            }
        }
    }
}
