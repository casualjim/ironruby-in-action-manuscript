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
            //TODO: update when hosting API changes
			ScriptRuntime runtime = IronRuby.CreateRuntime();
			ScriptEngine engine = IronRuby.GetEngine(runtime);
			ScriptScope scope = engine.CreateScope();


			scope.SetVariable("txt", "IronRuby is awesome!");
			scope.Execute("def self.upper; txt.to_upper; end;");


			string result = scope.GetVariable<Function<string>>("upper")();
			Console.WriteLine("The result is: " + result);
			Console.WriteLine("");


			Console.WriteLine("Press any key to close...");
			Console.ReadKey();


			// Outputs the following:
			// The result is: IRONRUBY IS AWESOME
			
			
        }
    }
}