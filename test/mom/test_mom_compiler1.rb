require_relative "helper"

module Mom
  class TestMomCompilerTranslate < MiniTest::Test
    include MomCompile

    def setup
      Parfait.boot!
      @comp = compile_mom( "class Test ; def main(); return 1; end; end;")
      @linker = @comp.translate(:interpreter)
    end

    def test_translate_class
      assert_equal Risc::Linker , @linker.class
    end
    def test_translate_platform
      assert_kind_of Risc::Platform , @linker.platform
    end
    def test_translate_assemblers
      assert_equal Risc::Assembler , @linker.assemblers.first.class
    end
    def test_assembler_code
      assert_equal Risc::Label , @linker.assemblers.first.instructions.class
    end
    def test_assembler_assembled
      assert_equal Risc::SlotToReg , @linker.assemblers.first.instructions.next.class
    end
    def test_no_loops_in_chain
      @linker.assemblers.each do |asm|
        all = []
        asm.instructions.each do |ins|
          assert !all.include?(ins) , "Double in #{asm.method.name}:#{ins}"
          all << ins
        end
      end
    end
    def test_no_risc
      @linker.position_all
      @linker.create_binary
      @linker.assemblers.each do |asm|
        asm.instructions.each do |ins|
          ins.assemble(Util::DevNull.new)
        end # risc instruction don't have an assemble
      end
    end
  end
end
