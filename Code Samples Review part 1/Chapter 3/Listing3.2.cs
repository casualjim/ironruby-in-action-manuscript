using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Scripting;
using Microsoft.Scripting.Hosting;
using Ruby;

namespace DLRHost
{
    class Program
    {
        static void Main(string[] args)
        {
            ScriptRuntime runtime = IronRuby.CreateRuntime();


			Console.WriteLine("Executing from file:");
			runtime.ExecuteFile("hello_world.rb");

			Console.WriteLine("Press any key to close...");
			Console.ReadKey();
			
        }
    }
}
