using System;
using System.Reflection.Emit;

namespace CSharp
{
    public class HelloWorldLCG
    {
        public static void Demonstrate()
        {
            DynamicMethod dm = new DynamicMethod("HelloWorld", typeof(void), new Type[] { }, typeof(HelloWorldLCG), false);

            ILGenerator il = dm.GetILGenerator();
            il.Emit(OpCodes.Ldstr, "hello, world");
            il.Emit(OpCodes.Call, typeof(Console).GetMethod("WriteLine", new Type[] { typeof(string) }));
            il.Emit(OpCodes.Ret);

            dm.Invoke(null, null);

        }     
    }
}