using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BugTrackerStatemachine
{
    class Program
    {
        static void Main(string[] args)
        {
            var bug = new Bug("The bug of bugs");
            bug.Assign("Tom");
            bug.Defer();
            bug.Assign("Ivan");
            bug.Assign("Adam");
            bug.Close();
            Console.WriteLine("All done");
        }
    }
}
