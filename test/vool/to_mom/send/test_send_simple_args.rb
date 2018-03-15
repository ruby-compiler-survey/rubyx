require_relative "../helper"
require_relative "simple_send_harness"

module Vool
  class TestSendSimpleArgsMom < MiniTest::Test
    include MomCompile
    include SimpleSendHarness

    def setup
      Risc.machine.boot
      @ins = compile_first_method( "5.mod4(1,2)")
    end

    def receiver
      [Mom::IntegerConstant , 5]
    end
    def test_args_two_move
      assert_equal :next_message, @ins.next(2).arguments[1].left.slots[0]
      assert_equal :arguments,    @ins.next(2).arguments[1].left.slots[1]
    end
    def test_args_two_str
      assert_equal Mom::IntegerConstant,    @ins.next(2).arguments[1].right.class
      assert_equal 2,    @ins.next(2).arguments[1].right.value
    end
    def test_array
      check_array [Mom::MessageSetup,Mom::SlotLoad,Mom::ArgumentTransfer,Mom::SimpleCall] , @ins
    end
  end
end
