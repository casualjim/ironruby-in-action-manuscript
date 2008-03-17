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
            runtime.ExecuteFile("..\\..\\hello_world.rb");

            ScriptEngine engine = IronRuby.GetEngine(runtime);
            ScriptScope scope = engine.CreateScope();

            List<string> strings = new List<string>();
            strings.Add("Hello, ");
            strings.Add("World!!!");
            IronRuby.GetExecutionContext(runtime).GlobalVariables[SymbolTable.StringToId("strings")] = strings;

            ScriptSource script = engine.CreateScriptSourceFromString(
 @"
puts ""Hello World! There are #{$strings.count.to_s} strings:""
$strings.each_with_index { |s,i| puts ""#{i}: #{s}"" }
");

            Console.WriteLine("Executing from string:");
            
        }
    }
}
