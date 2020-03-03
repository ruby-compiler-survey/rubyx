require_relative "helper"

module SlotMachine
  class TestNotSameCheck < SlotMachineInstructionTest
    def instruction
      target = Slotted.for(:message , [:caller])
      target2 = Slotted.for(:message , [:next_message])
      NotSameCheck.new(target , target2 , Label.new("ok" , "target"))
    end
    def test_len
      assert_equal 5 , all.length , all_str
    end
    def test_1_slot
      assert_slot_to_reg risc(1) ,:message , 6 , :"message.caller"
    end
    def test_2_slot
      assert_slot_to_reg risc(2) ,:message , 1 , :"message.next_message"
    end
    def test_3_op
      assert_operator risc(3) , :-, :"message.caller" , :"message.next_message"
    end
    def test_4_zero
      assert_zero risc(4) , "target"
    end
  end
end