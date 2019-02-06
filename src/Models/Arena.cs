using System;
using SmashBot.Extensions;

namespace SmashBot.Models
{
    public class Arena : IArena
    {
        public Arena(string id)
        {
            if (ValidIdArgument(id))
            {
                Id = id;
            }
        }

        public Arena(string id, string password)
        {
            if (ValidIdArgument(id) && ValidPasswordArgument(password))
            {
                Id = id;
                Password = password;
            }
        }

        public string Id { get; private set; }
        public string Password { get; private set; }

        private bool ValidIdArgument(string id)
        {
            if (id == null)
            {
                throw new ArgumentNullException(nameof(id));
            }
            if (id.Length != 5)
            {
                throw new ArgumentException($"'{id}' must have a length of 5", nameof(id));
            }
            if (!id.IsAlphaNumeric())
            {
                throw new ArgumentException($"'{id}' must be alphanumeric", nameof(id));
            }
            return true;
        }

        private bool ValidPasswordArgument(string password)
        {
            if (password != null && password.Length > 4)
            {
                throw new ArgumentException($"'{password}' must not be longer than 4 characters", nameof(password));
            }
            return true;
        }
    }
}
