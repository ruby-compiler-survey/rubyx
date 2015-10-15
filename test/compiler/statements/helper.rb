require_relative '../../helper'


module Statements

  def check
    machine = Virtual.machine.boot
    machine.parse_and_compile @string_input
    produced = Virtual.machine.space.get_main.source
    assert @expect , "No output given"
    assert_equal @expect.length ,  produced.blocks.length , "Block length"
    produced.blocks.each_with_index do |b,i|
      codes = @expect[i]
      assert codes , "No codes for block #{i}"
      assert_equal b.codes.length , codes.length , "Code length for block #{i+1}"
      b.codes.each_with_index do |c , ii |
        assert_equal codes[ii] ,  c.class ,  "Block #{i+1} , code #{ii+1}"
      end
    end
  end


end
