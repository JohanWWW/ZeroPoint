﻿using Antlr4.Runtime;
using Interpreter.Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Models
{
    public class FunctionCallStatement : ModelBase, IExpressionModel, IStatementModel
    {
        public string[] IdentifierPath { get; set; }
        public IExpressionModel[] Arguments { get; set; }

        public FunctionCallStatement() : base(Enums.ModelTypeCode.FunctionCallStatement)
        {
        }
    }
}
