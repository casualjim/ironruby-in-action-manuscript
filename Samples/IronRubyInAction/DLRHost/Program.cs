using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Scripting;
using Microsoft.Scripting.Hosting;
using Ruby;
using Ruby.Runtime;

namespace DLRHost
{
    class Program
    {
        static void Main(string[] args)
        {
            MyObjectContainer container = new MyObjectContainer();

            ScriptRuntime runtime = IronRuby.CreateRuntime();
            
            //Console.WriteLine("Executing from file:");
            //runtime.ExecuteFile("hello_world.rb");

            ScriptEngine engine = IronRuby.GetEngine(runtime);
            RubyExecutionContext ctx = IronRuby.GetExecutionContext(runtime);

            ctx.GlobalVariables[SymbolTable.StringToId("my_container")] = container;
            runtime.ExecuteSourceUnit(engine.CreateScriptSourceFromFile("commands.rb"));
            

            Console.WriteLine("Press any key to close...");
            Console.ReadKey();
            //runtime.Globals.GetVariable<MyObjectContainer>("my_container").Commands["show_me"]();

//            ScriptEngine engine = IronRuby.GetEngine(runtime);
//            ScriptScope scope = engine.CreateScope();
//
//            List<string> strings = new List<string>();
//            strings.Add("Hello, ");
//            strings.Add("World!!!");
//            IronRuby.GetExecutionContext(runtime).GlobalVariables[SymbolTable.StringToId("strings")] = strings;
//
//            ScriptSource script = engine.CreateScriptSourceFromString(
// @"
//puts ""Hello World! There are #{$strings.count.to_s} strings:""
//$strings.each_with_index { |s,i| puts ""#{i}: #{s}"" }
//");
//
//            Console.WriteLine("Executing from string:");
            
        }
    }


    public class MyObjectContainer
    {
        public MyObjectContainer()
        {
            Commands = new Dictionary<string, Action>();
            EventHandlers = new Dictionary<string, EventHandler>();
            Version = "Hello, world!!!";
        }

        public string Version { get; private set; }

        public Dictionary<string, Action> Commands { get; set; }
        public Dictionary<string, EventHandler> EventHandlers { get; set; }
    }
}
