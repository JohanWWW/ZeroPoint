﻿using Interpreter.Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Models
{
    public class ProviderStatementModel : IFunctionModel
    {
        public BlockModel Body { get; set; }
        public IExpressionModel Return { get; set; }
    }
}
