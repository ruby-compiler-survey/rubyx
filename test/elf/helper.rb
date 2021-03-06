require_relative "../helper"

module Elf

  class FullTest < MiniTest::Test

    def in_space(input)
      "class Space; #{input} ; end"
    end
    def as_main(input)
      in_space("def main(arg);#{input};end")
    end
    def check(input)
      linker = RubyX::RubyXCompiler.new(RubyX.default_test_options).ruby_to_binary( input , :arm )
      writer = Elf::ObjectWriter.new(linker)
      writer.save StringIO.new
    end
  end
end
