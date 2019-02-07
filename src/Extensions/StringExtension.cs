using System.Text.RegularExpressions;

namespace SmashBot.Extensions
{
    public static class StringExtension
    {
        public static bool IsAlphaNumeric(this string str)
        {
            var reg = new Regex(@"^[a-zA-Z0-9]*$");
            return reg.IsMatch(str);
        }
    }
}
