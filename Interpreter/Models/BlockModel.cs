﻿using Interpreter.Models.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Models
{
    public class BlockModel : ModelBase
    {
        public ICollection<IStatementModel> Statements { get; set; }

        public BlockModel() : base(Enums.ModelTypeCode.Block)
        {
        }
    }
}
