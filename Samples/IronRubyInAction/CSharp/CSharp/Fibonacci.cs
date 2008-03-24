using System;
namespace CSharp
{
    public static class Fibonacci
    {
        public static int WithoutRecursion(int n)
        {
            if (n < 1)
                return n;

            int previous = -1;
            int result = 1;
            
            for (int i = 0; i < n+1; i++)
            {
                int sum = result + previous;
                previous = result;
                result = sum;
            }

            return result;
        }

        public static int WithRecursion(int nr)
        {
            Func<int, int> fib = null;
            fib = n => n > 1 ? fib(n - 1) + fib(n - 2) : n;

            return fib(nr);
        }
    }
}