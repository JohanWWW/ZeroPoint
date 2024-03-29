﻿using Interpreter.Environment;
using Interpreter.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Models.Delegates
{
    /// <summary>
    /// A void method that accepts arguments
    /// </summary>
    public delegate void ConsumerMethod(IOperable[] args);
}
