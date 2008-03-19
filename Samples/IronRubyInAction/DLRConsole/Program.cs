using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Scripting.Hosting;
using Ruby;

namespace DLRConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            ScriptRuntime runtime = IronRuby.CreateRuntime();

            Console.WriteLine("Please enter a Ruby expression:");
            string expr = Console.ReadLine();

            
        }
    }
}
