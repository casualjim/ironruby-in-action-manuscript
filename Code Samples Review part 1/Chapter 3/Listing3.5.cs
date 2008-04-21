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
			ScriptEngine engine = IronRuby.GetEngine(runtime);
			ScriptScope scope = engine.CreateScope();
			StringAdder adder = new StringAdder();


			scope.Execute("def self.string_added(val = ''); puts \"The string \\\"#{val}\\\" has been added.\"; end;");
			StringAdder.OnStringAddedDelegate functionPointer = scope.GetVariable<StringAdder.OnStringAddedDelegate>("string_added");


			adder.OnStringAdded += functionPointer;


			Console.WriteLine("Initialisation complete. About to add some strings.\r\n");
			adder.Add("IronRuby");
			adder.Add("IronPython");
			adder.Add("VBx");
			adder.Add("Managed JavaScript");
			adder.Add("IronLisp");
			adder.Add("IronScheme");
			adder.Add("Nua");


			Console.WriteLine("\r\nSome DLR languages: " + adder);

			// Outputs the following:
			//
			// Initialisation complete. About to add some strings.
			//
			// The string "IronRuby" has been added.
			// The string "IronPython" has been added.
			// The string "VBx" has been added.
			// The string "Managed JavaScript" has been added.
			// The string "IronLisp" has been added.
			// The string "IronScheme" has been added.
			// The string "Nua" has been added.
			//
			// Some DLR languages: IronRuby, IronPython, VBx, Managed JavaScript, IronLisp, IronScheme, Nua
			
			
        }
    }
}