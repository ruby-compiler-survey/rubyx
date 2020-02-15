module SlotMachine
  # A Slot defines a slot. A bit like a variable name but for objects.
  #
  # PS: for the interested: A "development" of Smalltalk was the
  #     prototype based language (read: JavaScript equivalent)
  #     called Self https://en.wikipedia.org/wiki/Self_(programming_language)
  #
  # Slots are the instance names of objects. But since the language is dynamic
  # what is it that we can say about instance names at runtime?
  # Start with a known object like the Message (in register one), we know all it's
  # variables. But there is a Message in there, and for that we know the instances
  # too. And off course for _all_ objects we know where the type is.
  #
  # The definiion is an array of symbols that we can resolve to SlotLoad
  # Instructions. Or in the case of constants to ConstantLoad
  #
  class Slot
    # get the right definition, depending on the object
    def self.for(object , slots)
      case object
      when :message
        SlottedMessage.new(slots)
      when Constant
        SlottedConstant.new(object , slots)
      when Parfait::Object , Risc::Label
        SlottedObject.new(object , slots)
      else
        raise "not supported type #{object}"
      end
    end

    attr_reader :slots
    # is an array of symbols, that specifies the first the object, and then the Slot.
    # The first element is either a known type name (Capitalized symbol of the class name) ,
    # or the symbol :message
    # And subsequent symbols must be instance variables on the previous type.
    # Examples:  [:message , :receiver] or [:Space , :next_message]
    def initialize( slots)
      raise "No slots #{object}" unless slots
      slots = [slots] unless slots.is_a?(Array)
      @slots =  slots
    end

    def to_s
      names = [known_name] + @slots
      "[#{names.join(', ')}]"
    end


  end
end