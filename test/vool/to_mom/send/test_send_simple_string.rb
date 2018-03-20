require_relative "../helper"
require_relative "simple_send_harness"

module Vool
  class TestSendSimpleStringArgsMom < MiniTest::Test
    include MomCompile
    include SimpleSendHarness

    def setup
      Risc.machine.boot
      @ins = compile_first_method( "'5'.get_internal_byte(1)")
    end
    def receiver
      [Mom::StringConstant , "5"]
    end

    def test_args_one_move
      assert_equal :next_message, @ins.next.arguments[0].left.slots[0]
      assert_equal :arguments,    @ins.next.arguments[0].left.slots[1]
    end
    def test_args_one_str
      assert_equal Mom::IntegerConstant,    @ins.next.arguments[0].right.known_object.class
      assert_equal 1,    @ins.next.arguments[0].right.known_object.value
    end
  end
end
