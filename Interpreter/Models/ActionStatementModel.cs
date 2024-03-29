﻿using Antlr4.Runtime;
using Interpreter.Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Models
{
    public class ActionStatementModel : ModelBase, IFunctionModel
    {
        public BlockModel Body { get; set; }
        
        public ActionStatementModel() : base(Enums.ModelTypeCode.ActionStatement)
        {
        }
    }
}
