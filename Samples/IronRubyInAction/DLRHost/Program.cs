using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Scripting;
using Microsoft.Scripting.Hosting;
using Microsoft.Scripting.Utils;
using Ruby;
using Ruby.Runtime;
using Action=System.Action;

namespace DLRHost
{
    class Program
    {
        static void Main(string[] args)
        {
            
            //TODO: update when hosting API changes
//            ScriptScope scope = engine.CreateScope();

//            scope.SetVariable("txt", "IronRuby is awesome!");
//            scope.Execute("def self.upper; txt.to_s.upcase; end;");
//            
//            string result = scope.GetVariable<Function<string>>("upper")();
//            Console.WriteLine("The result is: " + result);
//            Console.WriteLine("");

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
                        
            Console.WriteLine("\r\nPress any key to close...");
            Console.ReadKey();


            
        }
    }

    public class StringAdder
    {
        private readonly List<string> _stringList;

        public StringAdder()
        {
            _stringList = new List<string>();
        }

        public void Add(string value)
        {
            _stringList.Add(value);
            OnStringAdded(value);
        }

        public override string ToString()
        {
            return string.Join(", ", _stringList.ToArray());
        }

        public delegate void OnStringAddedDelegate(string addedValue);
        public event OnStringAddedDelegate OnStringAdded;
    }


}
