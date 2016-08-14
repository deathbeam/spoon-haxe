package spoon;

import Parsihax.Parser as P;
import Parsihax.*;
using Parsihax;
using spoon.Parser;

class Parser {
  private static function trim(parser : P<String>) {
    return parser.skip(optWhitespace());
  }

  public function new() {

  }

  public function build() {
    var spoon = empty();

    // Operators

    // Keywords
    var Do = 'do'.string().trim();
    var End = 'end'.string().trim();
    var If = 'if'.string().trim();
    var Else = 'else'.string().trim();
    var For = 'for'.string().trim();
    var While = 'while'.string().trim();
    var Function = 'function'.string().trim();
    var Return = 'return'.string().trim();
    var Break = 'break'.string().trim();
    var Continue = 'continue'.string().trim();

    // Literals
    var String = ~/"((?:\\.|.)*?)"/.regexp(1).trim().desc('string');
    var Number = ~/-?(0|[1-9][0-9]*)([.][0-9]+)?([eE][+-]?[0-9]+)?/.regexp().trim().desc('number');
    var True = 'true'.string().trim();
    var False = 'false'.string().trim();
    var Null = 'null'.string().trim();
    var Literal = [ String, Number, True, False, Null ].choice();

    // Grammar
    var Statement : P<Dynamic> = Literal;
    var Body : P<Dynamic> = Statement.many();
    var Block : P<Dynamic> = Do.then(Body).skip(End).or(Statement);

    return spoon.parse = optWhitespace().then(Block);
  }
}