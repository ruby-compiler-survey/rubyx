require_relative "../helper"

module Risc
  class TestRegisterSlot < MiniTest::Test
    def setup
      Parfait.boot!(Parfait.default_test_options)
      @r0 = RegisterValue.new(:message , :Message)
      @r1 = RegisterValue.new(:id_1234 , :Space)
      @r2 = RegisterValue.new(:id_1256 , :Factory)
    end
    def test_class_name_type
      assert_equal :Message , @r0.class_name
    end
    def test_class_name_fix
      assert_equal :Integer , RegisterValue.new(:id_234 , :Integer).class_name
    end
    def test_r0
      assert_equal :message , @r0.symbol
    end
    def test_load_label
      label = Risc::Label.new("HI","ho" , FakeAddress.new(0))
      move = @r1 << label
      assert_equal LoadConstant , move.class
    end
    def test_transfer
      transfer = @r0 << @r1
      assert_equal Transfer , transfer.class
    end
    def test_index_op
      message = @r0[:next_message]
      assert_equal RegisterSlot , message.class
      assert_equal :next_message , message.index
      assert_equal @r0 , message.register
    end
    def test_operator
      ret = @r0.op :<< , @r1
      assert_equal OperatorInstruction , ret.class
      assert_equal @r0 , ret.left
      assert_equal @r1 , ret.right
      assert_equal :<< , ret.operator
    end
    def test_byte_to_reg
      instr = @r0 <= @r1[1]
      assert_equal ByteToReg , instr.class
      assert_equal @r1 , instr.array
      assert_equal @r0 , instr.register
      assert_equal 1 , instr.index
    end
    def est_slot_to_reg
      instr = @r0 << @r2[:next_object]
      assert_equal SlotToReg , instr.class
      assert_equal @r0 , instr.register
      assert_equal 2 , instr.index
      assert_equal @r1 , instr.array
    end
    def test_reg_to_byte
      instr = @r1[1] <= @r0
      assert_equal RegToByte , instr.class
      assert_equal @r1 , instr.array
      assert_equal @r0 , instr.register
      assert_equal 1 , instr.index
    end
    def est_reg_to_slot
      instr = @r2[:next_object] << @r0
      assert_equal RegToSlot , instr.class
      assert_equal @r0 , instr.register
      assert_equal 2 , instr.index
      assert_equal @r1 , instr.array
    end
  end
end