using Xunit;

namespace CSharp.Tests
{
    public class HelloWorldTest
    {
        [Fact]
        public void Print()
        {
            HelloWorld hw = new HelloWorld();

            Assert.Equal("Hello world !!!", hw.Print(), "The strings should be equal");
        }
    }
}
