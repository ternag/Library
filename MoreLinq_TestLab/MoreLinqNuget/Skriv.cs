using System;
using System.Collections.Generic;

namespace MoreLinqNuget
{
    public static class Skriv
    {
        public static void Print<T>(this IEnumerable<T> list)
        {
            foreach (T item in list)
            {
                Console.Out.WriteLine(item);
            }
        }

        public static void Print(this string item)
        {
            Console.Out.WriteLine(item);
        }

        public static string Flatten(this IEnumerable<string> list)
        {
            return string.Join(";", list);
        }
    }
}