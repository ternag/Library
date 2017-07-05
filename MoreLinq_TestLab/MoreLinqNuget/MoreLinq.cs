using System;
using System.Collections.Generic;
using System.Linq;
using MoreLinq;
using Xunit;

namespace MoreLinqNuget
{
    public class MoreLinq
    {
        private static readonly List<string> Numbers = new List<string>() { "one", "two", "three", "four", "five", "six", "seven", "eight" };
        private static readonly List<string> Names = new List<string>() { "ole", "tom", "tim", "finn", "frede", "sam", "søren", "ebbe" };

        [Fact]
        public void AssertCount_true()
        {
            Numbers.AssertCount(8);
        }

        [Fact]
        public void AssertCount_false()
        {
            Assert.Throws<SequenceException>(() => Numbers.AssertCount(4));
        }

        [Fact]
        public void Batch()
        {
            List<IEnumerable<string>> batch = Numbers.Batch(3).ToList();
            batch.ForEach(enumerable => enumerable.Flatten().Print());
        }

        [Fact]
        public void Concat_string()
        {
            IEnumerable<string> concat = Numbers.Concat("tail");
            concat.Flatten().Print();
        }

        [Fact]
        public void Concat_ListOfStrings()
        {
            IEnumerable<string> concat = Numbers.Concat(new[] { "nine", "ten" });
            concat.Print();
        }

        [Fact]
        public void Consume()
        {
            Numbers.Consume(); // ?????? why?
        }

        [Fact]
        public void DistinctBy()
        {
            IEnumerable<string> distinctBy = Numbers.DistinctBy(s => s.Length);
            distinctBy.Print();
        }

        //[Fact]
        //public void Zip()
        //{
        //    var equiZip = Numbers.Zip(Names, (s, s1) => s+s1);
        //    equiZip.Print();
        //}

        [Fact]
        public void EquiZip()
        {
            IEnumerable<string> equiZip = Numbers.EquiZip(Names, (s, s1) => s + ";" + s1); // hmmm - hvad er forskellen fra "normal" Zip?
            equiZip.Print();
        }

        [Fact]
        public void Exclude()
        {
            IEnumerable<string> exclude = Numbers.Exclude(3, 2);
            //IEnumerable<string> exclude = Numbers.Exclude(30,2); Works. No elements are excluded
            //IEnumerable<string> exclude = Numbers.Exclude(3,20); Works. Last five elements are excluded
            exclude.Print();
            Assert.Equal(new[] { "one", "two", "three", "six", "seven", "eight" }, exclude);
        }

        [Fact]
        public void AssertExtension()
        {
            IEnumerable<string> assert = Numbers.Assert(s => s.Length > 2); // try set "s.Length > 3"
            assert.Print();
        }

        [Fact]
        public void Cartesian()
        {
            IEnumerable<string> cartesian = Numbers.Cartesian(Names, (s, s1) => $"{s}-{s1}");
            cartesian.Print();
        }

        [Fact]
        public void Fold()
        {
            var fold = new[] { "one", "two", "three" }.Fold((s, s1, s2) => s + s1 + s2);
            Console.Out.WriteLine(fold);
        }

        [Fact]
        public void ForEach()
        {
            Numbers.ForEach((s, i) => $"[{i}]{s}".Print());
        }

        [Fact]
        public void FullGroupJoin()
        {
            IEnumerable<string> fullGroupJoin = Numbers.FullGroupJoin(Names, firstKey => firstKey.Substring(0, 1), secKey => secKey.Substring(0, 1), (s, seq1, seq2) => $"{s}, '{seq1.Flatten()}', {seq1.Count()}, '{seq2.Flatten()}', {seq2.Count()}");
            fullGroupJoin.Print();
        }

        [Fact]
        public void Incremental()
        {
            var incremental = Names.Incremental((s, s1, index) => $"{s};{s1};{index}");
            incremental.Print();
        }

        [Fact]
        public void Index_default()
        {
            var index = Names.Index();
            index.Print();
        }

        [Fact]
        public void Index_WithStartIndex()
        {
            var index = Names.Index(13);
            index.Print();
        }

        [Fact]
        public void Interleave()
        {
            IEnumerable<string> interleave = Names.Interleave(Numbers);
            interleave.Print();
        }

        [Fact]
        public void Lag()
        {
            var lag = Numbers.Lag(3, (s, s1) => $"{s};{s1}");
            lag.Print();
        }

        [Fact]
        public void Lead()
        {
            var lead = Numbers.Lead(2, (s, s1) => $"{s};{s1}");
            lead.Print();
        }

        [Fact]
        public void Pad_default()
        {
            var pad = Numbers.Pad(20);
            pad.Flatten().Print();
        }

        [Fact]
        public void Pad_WithFunction()
        {
            var pad = Numbers.Pad(20, i => "item_" + i);
            pad.Flatten().Print();
        }

        [Fact]
        public void Pad_WithString()
        {
            var pad = Numbers.Pad(20, "item");
            pad.Flatten().Print();
        }



    }
}