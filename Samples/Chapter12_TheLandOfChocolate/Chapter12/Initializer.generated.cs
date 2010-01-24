/* ****************************************************************************
 *
 * Copyright (c) Microsoft Corporation. 
 *
 * This source code is subject to terms and conditions of the Microsoft Public License. A 
 * copy of the license can be found in the License.html file at the root of this distribution. If 
 * you cannot locate the  Microsoft Public License, please send an email to 
 * ironruby@microsoft.com. By using this source code in any fashion, you are agreeing to be bound 
 * by the terms of the Microsoft Public License.
 *
 * You must not remove this notice, or any other, from this software.
 *
 *
 * ***************************************************************************/

#pragma warning disable 169 // mcs: unused private method
[assembly: IronRuby.Runtime.RubyLibraryAttribute(typeof(Chapter12.Chapter12LibraryInitializer))]

namespace Chapter12 {
    using System;
    using Microsoft.Scripting.Utils;
    
    public sealed class Chapter12LibraryInitializer : IronRuby.Builtins.LibraryInitializer {
        protected override void LoadModules() {
            IronRuby.Builtins.RubyClass classRef0 = GetClass(typeof(System.Object));
            
            
            IronRuby.Builtins.RubyModule def1 = DefineGlobalModule("TheLandOfChocolate", typeof(Chapter12.TheLandOfChocolate), 0x00000008, null, null, null, IronRuby.Builtins.RubyModule.EmptyArray);
            IronRuby.Builtins.RubyClass def2 = DefineClass("TheLandOfChocolate::Chocolate", typeof(Chapter12.TheLandOfChocolate.Chocolate), 0x00000008, classRef0, LoadTheLandOfChocolate__Chocolate_Instance, null, LoadTheLandOfChocolate__Chocolate_Constants, IronRuby.Builtins.RubyModule.EmptyArray, 
                new Func<IronRuby.Builtins.RubyClass, Chapter12.TheLandOfChocolate.Chocolate>(Chapter12.TheLandOfChocolate.Chocolate.Create)
            );
            object def3 = DefineSingleton(OompaLoompa_Instance, null, null, IronRuby.Builtins.RubyModule.EmptyArray);
            SetConstant(def1, "Chocolate", def2);
            SetConstant(def1, "OompaLoompa", def3);
        }
        
        private static void LoadTheLandOfChocolate__Chocolate_Constants(IronRuby.Builtins.RubyModule/*!*/ module) {
            SetConstant(module, "DEFAULT_CHOCOLATE_COLOUR", Chapter12.TheLandOfChocolate.Chocolate.DEFAULT_CHOCOLATE_COLOUR);
            
        }
        
        private static void LoadTheLandOfChocolate__Chocolate_Instance(IronRuby.Builtins.RubyModule/*!*/ module) {
            DefineLibraryMethod(module, "dark?", 0x11, 
                new Func<Chapter12.TheLandOfChocolate.Chocolate, System.Boolean>(Chapter12.TheLandOfChocolate.Chocolate.IsDark)
            );
            
            DefineLibraryMethod(module, "eat!", 0x11, 
                new Action<Chapter12.TheLandOfChocolate.Chocolate>(Chapter12.TheLandOfChocolate.Chocolate.Eat)
            );
            
            DefineLibraryMethod(module, "milk?", 0x11, 
                new Func<Chapter12.TheLandOfChocolate.Chocolate, System.Boolean>(Chapter12.TheLandOfChocolate.Chocolate.IsMilk)
            );
            
            DefineLibraryMethod(module, "white?", 0x11, 
                new Func<Chapter12.TheLandOfChocolate.Chocolate, System.Boolean>(Chapter12.TheLandOfChocolate.Chocolate.IsWhite)
            );
            
        }
        
        private static void OompaLoompa_Instance(IronRuby.Builtins.RubyModule/*!*/ module) {
            DefineLibraryMethod(module, "make_chocolate", 0x11, 
                new Func<IronRuby.Builtins.RubyClass, System.String, System.String, Chapter12.TheLandOfChocolate.Chocolate>(Chapter12.TheLandOfChocolate.OompaLoompa.MakeChocolate)
            );
            
            DefineLibraryMethod(module, "make_peppermint_chocolate", 0x11, 
                new Func<IronRuby.Builtins.RubyClass, System.String, Chapter12.TheLandOfChocolate.Chocolate>(Chapter12.TheLandOfChocolate.OompaLoompa.MakePepermintChocolate)
            );
            
        }
        
    }
}

