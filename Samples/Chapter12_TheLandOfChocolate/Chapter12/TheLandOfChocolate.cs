using IronRuby.Builtins;
using IronRuby.Runtime;

namespace Chapter12
{
    [RubyModule]
    public static class TheLandOfChocolate
    {
        #region Nested type: Chocolate

        [RubyClass("Chocolate", Inherits = typeof (object))]
        public class Chocolate : RubyObject
        {
            [RubyConstant] public const string DEFAULT_CHOCOLATE_COLOUR = "milk";

            public Chocolate(RubyClass cls) : base(cls)
            {
                Colour = DEFAULT_CHOCOLATE_COLOUR;
            }

            public string Colour { get; set; }

            [RubyConstructor]
            public static Chocolate /*!*/ Create(RubyClass /*!*/ self)
            {
                return new Chocolate(self);
            }

            [RubyMethod("white?")]
            public static bool IsWhite(Chocolate self)
            {
                return self.Colour == "white";
            }

            [RubyMethod("milk?")]
            public static bool IsMilk(Chocolate self)
            {
                return self.Colour == "milk";
            }

            [RubyMethod("dark?")]
            public static bool IsDark(Chocolate self)
            {
                return self.Colour == "dark";
            }

            [RubyMethod("eat!")]
            public static void Eat(Chocolate self)
            {
            }
        }

        #endregion

        #region Nested type: OompaLoompa

        [RubySingleton]
        public class OompaLoompa
        {
            [RubyMethod("make_chocolate")]
            public static Chocolate MakeChocolate(RubyClass self, string colour = "milk", string flavour = "plain")
            {
                return new Chocolate(self);
            }

            [RubyMethod("make_peppermint_chocolate")]
            public static Chocolate MakePepermintChocolate(RubyClass self, string colour = "milk")
            {
                return new Chocolate(self);
            }
        }

        #endregion
    }
}