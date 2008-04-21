namespace CSharp
{
    public class Book : IPrintable
    {
        private readonly string message;

        public Book(string message)
        {
            this.message = message;
        }

        public string Message
        {
            get { return message; }
        }

        public string Print()
        {
            return string.Format("Book: {0}", message);
        }
    }
}