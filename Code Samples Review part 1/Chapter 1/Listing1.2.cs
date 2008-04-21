namespace CSharp
{
    public class TypeInference
    {
        public static void Demonstrate()
        {
            var i = 5;

            i = i + 5;

            System.Console.WriteLine("Inferred type: {0}, value: {1}", i.GetType().Name, i);

            // i = "hello"; // Still won't compile because i is inferred as an int

            System.Console.WriteLine("Converted type: {0}, value: \"{1}\"", i.ToString().GetType().Name, i);
        }
    }
}