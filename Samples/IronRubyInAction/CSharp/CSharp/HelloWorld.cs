namespace CSharp
{
    public class HelloWorld
    {
        private readonly string message;

        public HelloWorld()
        {
            message = "Hello world !!!";
        }

        public string Print()
        {
            return message;
        }
    }
}