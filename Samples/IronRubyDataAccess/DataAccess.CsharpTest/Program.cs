using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.LightSpeed;
using Mindscape.LightSpeed;

namespace DataAccess.CsharpTest
{
    class Program
    {
        static void Main(string[] args)
        {
            IList<Customer> customer = Repository.Find<Customer>();

            customer.ToList().ForEach(c => Console.WriteLine(c.CompanyName));
        }
    }
}
