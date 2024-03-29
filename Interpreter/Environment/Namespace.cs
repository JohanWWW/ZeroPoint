﻿using Interpreter.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Environment
{
    public class Namespace
    {
        private IDictionary<string, IOperable> _importedBindings;

        public string Name { get; private set; }
        public Scoping Scope { get; private set; }

        public Namespace(string name)
        {
            Name = name;
            Scope = new Scoping();
            _importedBindings = new Dictionary<string, IOperable>();
        }

        public Namespace(string name, Namespace importNs)
        {
            Name = name;
            Scope = new Scoping();
            _importedBindings = new Dictionary<string, IOperable>();
            foreach (var kvp in importNs.Scope.GetBindings())
            {
                _importedBindings.Add(kvp);
            }
        }

        public void Import(Namespace ns)
        {
            foreach (var kvp in ns.Scope.GetBindings())
            {
                _importedBindings.Add(kvp);
            }
        }

        public IDictionary<string, IOperable> GetImportedBindings() => _importedBindings;

        public bool TryGetImportedBinding(string identifier, out IOperable value) =>
            _importedBindings.TryGetValue(identifier, out value);

        public IOperable GetImportedValue(string identifier) => _importedBindings[identifier];

        public void AddOrUpdateBinding(string identifier, IOperable value) => _importedBindings[identifier] = value;

        public bool TryAddImportedBinding(string identifier, IOperable value) =>
            _importedBindings.TryAdd(identifier, value);

        public override string ToString() => $"{nameof(Namespace)}(\"{Name}\")";
    }
}
