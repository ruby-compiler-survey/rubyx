module Virtual

  #  collect anything that is in the space but and reachable from init
  class Collector
    def run
      # init= Parfait::Space.object_space.get_class_by_name("Kernel").get_instance_method "__init__"
      Virtual.machine.objects.clear
      keep Parfait::Space.object_space , 0
    end

    def keep object , depth
      return if object.nil?
      #puts "adding #{' ' * depth}:#{object.class}"
      #puts "ADD #{object.first.class}, #{object.last.class}" if object.is_a? Array
      return unless Virtual.machine.add_object object
      return unless object.respond_to? :has_layout?
      if( object.is_a? Parfait::Method)
        object.source.constants.each{|c|
          #puts "keeping constant #{c.class}:#{c.object_id}"
          keep(c , depth + 1)
        }
      end
      layout = object.get_layout
      keep(layout  , depth + 1)
      layout.object_instance_names.each do |name|
        inst = object.get_instance_variable name
        keep(inst , depth + 1)
      end
      if object.is_a? Parfait::List
        object.each do |item|
          keep(item , depth + 1)
        end
      end
    end
  end
end
