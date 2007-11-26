using System;
using System.Reflection;
using System.Reflection.Emit;
using System.Threading;

namespace CSharp
{
    public class HelloWorldEmit
    {
        public static void Demonstrate()
        {
            // create a dynamic assembly and module 
            AssemblyName assemblyName = new AssemblyName();
            assemblyName.Name = "HelloWorld";
            AssemblyBuilder assemblyBuilder = Thread.GetDomain().DefineDynamicAssembly(assemblyName, AssemblyBuilderAccess.RunAndSave);
            ModuleBuilder module;
            module = assemblyBuilder.DefineDynamicModule("HelloWorld.exe");

            // create a new type to hold our Main method
            TypeBuilder typeBuilder = module.DefineType("HelloWorldType", TypeAttributes.Public | TypeAttributes.Class);

            // create the Main(string[] args) method
            MethodBuilder methodbuilder = typeBuilder.DefineMethod("Main", MethodAttributes.HideBySig | MethodAttributes.Static | MethodAttributes.Public, typeof(void), new Type[] { typeof(string[]) });

            // generate the IL for the Main method
            ILGenerator ilGenerator = methodbuilder.GetILGenerator();
            ilGenerator.EmitWriteLine("hello, world");
            ilGenerator.Emit(OpCodes.Ret);

            // bake it
            Type helloWorldType = typeBuilder.CreateType();

            // run it
            helloWorldType.GetMethod("Main").Invoke(null, new string[] { null });

            // set the entry point for the application and save it
            assemblyBuilder.SetEntryPoint(methodbuilder, PEFileKinds.ConsoleApplication);
            assemblyBuilder.Save("HelloWorld.exe");
        }
    }
}