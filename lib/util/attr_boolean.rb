# It includes the class method "attr_boolean :name"
module GameMines
  module AttrBoolean
    def self.included(base)
      base.extend ClassMethods
    end

    # Class methods
    module ClassMethods
      def attr_boolean(*names)
        names.each do |name|
          class_eval "
            def #{name}?
              @#{name} ||= false
            end
            def #{name}!
              @#{name} = true
            end
            def #{name}=(value)
              @#{name} = value
            end
          "
        end
      end
    end
  end
end
