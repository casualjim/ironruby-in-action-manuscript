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
            //TODO: review this when the hosting api changes.
            IScriptEnvironment runtime = ScriptEnvironment.GetEnvironment();

            Console.WriteLine("Executing from file:");
            runtime.ExecuteFile("..\\..\\hello_world.rb");

            IScriptEngine engine = IronRuby.GetEngine(runtime);
            IScriptScope scope = engine.CreateScope();

            List<string> strings = new List<string>();
            strings.Add("Hello, ");
            strings.Add("World!!!");
            IronRuby.GetExecutionContext(runtime).GlobalVariables[SymbolTable.StringToId("strings")] = strings;

            SourceUnit script = engine.CreateScriptSourceFromString(
 @"
puts ""Hello World! There are #{$strings.count.to_s} strings:""
$strings.each_with_index { |s,i| puts ""#{i}: #{s}"" }
");

            Console.WriteLine("Executing from string:");
            engine.Execute(scope, script);
        }
    }
}
