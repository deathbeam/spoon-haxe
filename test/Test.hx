package test;

import Parsihax.Function;
import Parsihax.formatError;
import spoon.Parser;

class Test {
  public static function main() {
    var text = 'do
      true
      false
      null
      "Hello"
      4234
    end';

    printAndParse('Spoon', text, new Parser().build());
  }

  private static function printAndParse<T>(name : String, input : String, parse : Function<T>) {
    trace('-----------------------------------');
    trace('Parser input ($name)');
    trace('-----------------------------------');
    trace('$input');
    trace('-----------------------------------');
    trace('Parser output ($name)');
    trace('-----------------------------------');

    var output = parse(input);

    trace(output.status
      ? Std.string(output.value)
      : formatError(output, input)
    );
  }
}