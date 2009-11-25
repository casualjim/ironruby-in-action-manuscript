using System;
using System.IO;

namespace MonoBugTrackerStatemachine
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			var bug = new Bug("The bug of bugs");
			bug.Assign("Tom");
			bug.Defer();
			bug.Assign("Ivan");
			bug.Assign("Adam");
			bug.Close();
			Console.WriteLine ("All done");
		}
	}
}
