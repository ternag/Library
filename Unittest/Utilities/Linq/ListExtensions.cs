using System;
using System.Collections.Generic;
using System.Reflection;

namespace Unittest.Utilities.Linq
{
    public static class ListExtension
    {
        private static readonly Random Random = new Random();

        public static T GetRandom<T>(this IList<T> list)
        {
            var index = Random.Next(0, list.Count-1);
            return list[index];
        }
    }
}