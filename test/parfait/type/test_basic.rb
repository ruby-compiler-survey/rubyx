require_relative "../helper"

module Parfait
  class BasicType < ParfaitTest

    def setup
      super
      @mess = @space.get_next_for(:Message)
      assert @mess
      @type = @mess.get_type()
    end

    def test_type_index
      assert_equal @mess.get_type , @mess.get_internal_word(Parfait::TYPE_INDEX) , "mess"
    end

    def test_type_is_first
      type = @mess.get_type
      assert_equal 0 , type.variable_index(:type)
    end

    def test_length
      assert @mess
      assert @mess.get_type
      assert_equal 15 , @mess.get_type.instance_length , @mess.get_type.inspect
    end

    def test_names
      assert @type.names
    end
    def test_types
      assert @type.types
    end

    def test_type_length
      assert_equal 15 , @mess.get_type.instance_length , @mess.get_type.inspect
    end

    def test_type_length_index
      type = @mess.get_type.get_type
      assert_equal 4 , type.variable_index(:methods)
      assert_equal type.object_class , type.get_internal_word(3)
    end

    def test_no_index_below_0
      type = @mess.get_type
      names = type.names
      assert_equal 15 , names.get_length , names.inspect
      names.each do |n|
        assert type.variable_index(n) >= 0
      end
    end

    def test_attribute_set
      @mess.set_receiver( 55)
      assert_equal 55 , @mess.receiver
    end

    def test_variable_index
      assert_equal 1 , @type.variable_index(:next_message)
    end
    def test_name_at
      assert_equal :next_message , @type.name_at(1)
    end
    def test_type_at
      assert_equal :Message , @type.type_at(1)
    end
    def test_type_for
      assert_equal :Message , @type.type_for(:next_message)
    end

    def test_remove_me
      type = @mess.get_type
      assert_equal type , @mess.get_internal_word(0)
    end
    def test_to_s
      assert @type.to_s.include?(@type.object_class.name.to_s)
    end
    def test_class_name
      assert_equal :Message , @type.class_name
    end
  end
end
