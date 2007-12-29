using NUnit.Framework;
using System;

namespace CSharp.Tests
{
    [TestFixture]
    public class HelloWorldTest
    {
        [Test]
        public void Print()
        {
            HelloWorld hw = new HelloWorld();
            Assert.AreEqual("Hello world !!!", hw.Print(), "The strings should be equal");
        }

        [Test]
        public void IntMaxValue()
        {
            Console.WriteLine(Int64.MaxValue);
            Console.WriteLine(int.MaxValue);
            Console.WriteLine(float.MaxValue);
        }

        [Test]
        public void MathHelper()
        {
            var nr = -586;
            var actual = Math.Abs(nr);

            Assert.AreEqual(586, actual);
        }
    }
}
