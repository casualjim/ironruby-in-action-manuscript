.assembly helloworld {}

.method public static void MyMain() cil managed
{
  	.entrypoint

  	ldstr	"hello world!"
  	call	void [mscorlib]System.Console::WriteLine(string)
  	ret
}