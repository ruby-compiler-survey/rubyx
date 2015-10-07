module Parfait
  class Variable < Object

    def initialize type , name , value = nil
      raise "not type #{type}" unless type == :ref or type == :int
      self.type , self.name , self.value = type , name , value
      self.value = 0 if self.type == :int and value == nil
      raise "must give name for variable" unless name
    end
    attributes [:type , :name, :value]

    def to_s
      "Variable(#{self.type} ,#{self.name})"
    end
    def inspect
      to_s
    end
  end
end