package spoon;

import Parsihax.*;
using Parsihax;
using spoon.Grammar;

class Grammar {
  private static function trim(parser : Parser<String>) {
    return parser.skip(optWhitespace());
  }

  public static function build() {
    // Operators
    var PComma = ','.char().trim();

    // Keywords
    var PDo = 'do'.string().trim();
    var PEnd = 'end'.string().trim();
    var PIf = 'if'.string().trim();
    var PElse = 'else'.string().trim();
    var PFor = 'for'.string().trim();
    var PWhile = 'while'.string().trim();
    var PFunction = 'function'.string().trim();
    var PReturn = 'return'.string().trim();
    var PBreak = 'break'.string().trim();
    var PContinue = 'continue'.string().trim();

    // Literals
    var PString = ~/"((?:\\.|.)*?)"/.regexp(1).trim().desc('string');
    var PNumber = ~/-?(0|[1-9][0-9]*)([.][0-9]+)?([eE][+-]?[0-9]+)?/.regexp().trim().desc('number');
    var PTrue = 'true'.string().trim();
    var PFalse = 'false'.string().trim();
    var PNull = 'null'.string().trim();
    var PLiteral = [ PString, PNumber, PTrue, PFalse, PNull ].choice();

    // Grammar
    var PExp = PLiteral;
    var PExpList = PExp.sepBy1(PComma);
    var PStatement = PExp;
    var PReturnStatement = PReturn.then(PExpList.or([].of()));
    var PBody : Parser<Dynamic> = [PStatement.many(), PReturnStatement.or([].of())].seq();
    var PBlock : Parser<Dynamic> = PDo.then(PBody).skip(PEnd).or(PStatement);

    return optWhitespace().then(PBlock);
  }
}
