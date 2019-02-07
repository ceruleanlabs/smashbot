using System;
using SmashBot.Models;
using Xunit;

namespace SmashBotTests
{
    public class ArenaTests
    {
        [Fact]
        public void TestConstructorIdCannotBeNull()
        {
            // arrange
            // act
            var ex = Record.Exception(() => new Arena(null));

            // assert
            Assert.IsType<ArgumentNullException>(ex);
        }

        [Fact]
        public void TestConstructorIdLengthIsFive()
        {
            // arrange
            // act
            var ex = Record.Exception(() => new Arena("ABCD"));

            // assert
            Assert.IsType<ArgumentException>(ex);
        }

        [Fact]
        public void TestConstructorIdIsAlphaNumeric()
        {
            // arrange
            // act
            var ex = Record.Exception(() => new Arena("ABC1-"));

            // assert
            Assert.IsType<ArgumentException>(ex);
        }
    }
}
