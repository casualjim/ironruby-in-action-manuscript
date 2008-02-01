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
        }
    }
}
