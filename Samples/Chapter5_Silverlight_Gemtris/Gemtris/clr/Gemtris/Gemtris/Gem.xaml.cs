using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

namespace Gemtris
{
    public partial class Gem : UserControl
    {
        public Gem()
        {
            InitializeComponent();
        }

        private void GemClicked(object sender, MouseButtonEventArgs e)
        {
            this.GemBackground.Fill = new SolidColorBrush(Colors.Yellow);
        }
    }
}
