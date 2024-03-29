﻿using Interpreter.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Environment
{
    public class Scoping
    {
        private readonly IDictionary<string, IOperable> _bindings;

        private Scoping _outer = null;

        public Scoping() =>
            _bindings = new Dictionary<string, IOperable>();

        public bool ContainsLocalBinding(string identifier) => _bindings.ContainsKey(identifier);

        public bool ContainsGlobalBinding(string identifier)
        {
            Scoping currentScope = this;
            while (currentScope != null)
            {
                if (currentScope.ContainsLocalBinding(identifier))
                    return true;

                currentScope = currentScope._outer;
            }
            return false;
        }

        public IOperable GetLocalValue(string identifier) => _bindings[identifier];

        public bool TryGetLocalValue(string identifier, out IOperable value) =>
            _bindings.TryGetValue(identifier, out value);

        public IOperable GetGlobalValue(string identifier)
        {
            Scoping currentScope = this;
            while (currentScope != null)
            {
                if (currentScope.ContainsLocalBinding(identifier))
                    return currentScope.GetLocalValue(identifier);

                currentScope = currentScope._outer;
            }

            throw new KeyNotFoundException($"Could not find variable named '{identifier}'");
        }

        public bool TryGetGlobalBinding(string identifier, out IOperable value)
        {
            Scoping currentScope = this;
            while (currentScope != null)
            {
                if (currentScope.TryGetLocalValue(identifier, out value))
                    return true;

                currentScope = currentScope._outer;
            }

            value = null;
            return false;
        }

        public void SetGlobalBinding(string identifier, IOperable value)
        {
            Scoping currentScope = this;
            while (currentScope != null)
            {
                if (currentScope.ContainsLocalBinding(identifier))
                {
                    currentScope._bindings[identifier] = value;
                    return;
                }

                currentScope = currentScope._outer;
            }

            throw new KeyNotFoundException($"Could not find variable named '{identifier}'");
        }

        public void AddLocalBinding(string identifier, IOperable value)
        {
            _bindings.Add(identifier, value);
        }

        public bool TryAddLocalBinding(string identifier, IOperable value) =>
            _bindings.TryAdd(identifier, value);

        public void UpdateLocalBinding(string identifier, IOperable value) =>
            _bindings[identifier] = value;

        public void ConsumeScope(Scoping scope)
        {
            foreach (var kvp in scope.GetBindings())
            {
                AddLocalBinding(kvp.Key, kvp.Value);
            }
        }

        /// <summary>
        /// Sets the outer/parent scope of current scope
        /// </summary>
        public void SetOuterScope(Scoping scope)
        {
            _outer = scope;
        }

        public IDictionary<string, IOperable> GetBindings() => _bindings;
    }
}
