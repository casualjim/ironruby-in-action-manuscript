namespace CSharp
{
    public class StaticTyping
    {
        public static void Demonstrate()
        {
            int i = 5;
            i += 5;
            //This is valid because console writeline has an appropriate overload defined.
            System.Console.WriteLine(i); 

            // i = "hello"; // won't compile because we labeled i to be an int.

            // To convert this value to a string we can rely on the limited type coercion that the C# compiler understands.
            // or we can convert it explicitly
            string coerced = "" + i;
            string converted = i.ToString();

            System.Console.WriteLine("Coerced: {0}", coerced);
            System.Console.WriteLine("Converted: {0}", converted);
            
        }
    }
}