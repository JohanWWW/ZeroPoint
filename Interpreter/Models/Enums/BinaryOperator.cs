﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Interpreter.Models.Enums
{
    public enum BinaryOperator
    {
        Add,
        Sub,
        Mult,
        Div,
        Mod,
        Equal,
        StrictEqual,
        NotEqual,
        StrictNotEqual,
        LessThan,
        LessThanOrEqual,
        GreaterThan,
        GreaterThanOrEqual,
        LogicalAnd,
        LogicalOr,
        LogicalXOr,
        BitwiseAnd,
        BitwiseOr,
        BitwiseXOr,
        ShiftLeft,
        ShiftRight
    }
}
