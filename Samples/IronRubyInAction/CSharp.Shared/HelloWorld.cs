using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CSharp.Shared
{
    public class HelloWorld
    {
        private string message;

        public HelloWorld()
        {
            message = "Hello world !!!";
        }

        public string Message
        {
            get { return message; }
            set { message = value; }
        }

        public string Print()
        {
            return message;
        }
    }
}
