package test;

import buddy.SingleSuite;
using buddy.Should;
import spoon.Grammar;

class Test extends SingleSuite {
  public function new() {
    describe("Spoon", {
      var result = false;
      var parse = Grammar.build();

      beforeEach({
        result = false;
      });

      describe("Block", {
        var input = 'do
          true
          false
          null
          "Hello"
          4234
        end';

        beforeEach({
          result = parse(input).status;
        });

        it('should parse "$input"', {
          result.should.be(true);
        });
      });
    });
  }
}
