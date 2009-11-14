﻿#pragma checksum "..\..\Gem.xaml" "{406ea660-64cf-4c82-b6f0-42d48172a799}" "073277442FF34C0DA606ED1A49292CE6"
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3053
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Diagnostics;
using System.Windows;
using System.Windows.Automation;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Markup;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Media.Effects;
using System.Windows.Media.Imaging;
using System.Windows.Media.Media3D;
using System.Windows.Media.TextFormatting;
using System.Windows.Navigation;
using System.Windows.Shapes;


namespace Gemtris {
    
    
    /// <summary>
    /// Gem
    /// </summary>
    public partial class Gem : System.Windows.Controls.UserControl, System.Windows.Markup.IComponentConnector {
        
        
        #line 9 "..\..\Gem.xaml"
        internal System.Windows.Controls.Canvas GemCanvas;
        
        #line default
        #line hidden
        
        
        #line 10 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path GemBackground;
        
        #line default
        #line hidden
        
        
        #line 11 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path GemOutsideBorder;
        
        #line default
        #line hidden
        
        
        #line 12 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path TopFacetHighlight;
        
        #line default
        #line hidden
        
        
        #line 13 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path TopLeftFacetHighlight;
        
        #line default
        #line hidden
        
        
        #line 14 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path LeftFacetHighlight;
        
        #line default
        #line hidden
        
        
        #line 15 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path BottomLeftFacetHighlight;
        
        #line default
        #line hidden
        
        
        #line 16 "..\..\Gem.xaml"
        internal System.Windows.Shapes.Path GemInsideSurfaceBorder;
        
        #line default
        #line hidden
        
        private bool _contentLoaded;
        
        /// <summary>
        /// InitializeComponent
        /// </summary>
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        public void InitializeComponent() {
            if (_contentLoaded) {
                return;
            }
            _contentLoaded = true;
            System.Uri resourceLocater = new System.Uri("/Gemtris;component/gem.xaml", System.UriKind.Relative);
            
            #line 1 "..\..\Gem.xaml"
            System.Windows.Application.LoadComponent(this, resourceLocater);
            
            #line default
            #line hidden
        }
        
        [System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes")]
        void System.Windows.Markup.IComponentConnector.Connect(int connectionId, object target) {
            switch (connectionId)
            {
            case 1:
            this.GemCanvas = ((System.Windows.Controls.Canvas)(target));
            return;
            case 2:
            this.GemBackground = ((System.Windows.Shapes.Path)(target));
            return;
            case 3:
            this.GemOutsideBorder = ((System.Windows.Shapes.Path)(target));
            return;
            case 4:
            this.TopFacetHighlight = ((System.Windows.Shapes.Path)(target));
            return;
            case 5:
            this.TopLeftFacetHighlight = ((System.Windows.Shapes.Path)(target));
            return;
            case 6:
            this.LeftFacetHighlight = ((System.Windows.Shapes.Path)(target));
            return;
            case 7:
            this.BottomLeftFacetHighlight = ((System.Windows.Shapes.Path)(target));
            return;
            case 8:
            this.GemInsideSurfaceBorder = ((System.Windows.Shapes.Path)(target));
            return;
            }
            this._contentLoaded = true;
        }
    }
}
