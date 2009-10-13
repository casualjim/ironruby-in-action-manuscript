namespace CSharp
{
    public class HelloWorld : IPrintable
    {
        private readonly string message;

        public HelloWorld()
        {
            message = "Hello world !!!";
        }

        public string Message
        {
            get { return message; }
        }

        public string Print()
        {
            return message;
        }
    }
}