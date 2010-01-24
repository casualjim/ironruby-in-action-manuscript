using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IronRuby.Runtime;

namespace Chapter12
{
    [RubyModule]
    public static class TheLandOfChocolate
    {
        [RubySingleton]
        public class OompaLoompa
        {
            [RubyMethod("make_chocolate", RubyMethodAttributes.Singleton)]
            public static Chocolate MakeChocolate(string colour = "milk", string flavour = "plain")
            {
                return new Chocolate();
            }

            private Chocolate MakePepermintChocolate(string colour = "milk")
            {
                return new Chocolate();
            }
        }

        [RubyClass("Chocolate")]
        public class Chocolate
        {
            [RubyConstant]
            private const string DEFAULT_CHOCOLATE_COLOUR = "milk";

            private string colour = DEFAULT_CHOCOLATE_COLOUR;

            public string Colour
            {
                get;
                set;
            }

			public Chocolate() 
			{
				
			}
			
            [RubyMethod("white?")]
            public bool IsWhite()
            {
                return this.Colour == "white";
            }

            [RubyMethod("milk?")]
            public bool IsMilk()
            {
                return this.Colour == "milk";
            }

            [RubyMethod("dark?")]
            public bool IsDark()
            {
                return this.Colour == "dark";
            }

            [RubyMethod("eat!")]
            public void Eat()
            {

            }
        }
    }
}
