require 'test/unit'
require 'minitest/mock'

module GameMines
  # Disable some tests
  module TestDisabler
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Class methods
    module ClassMethods
      def enable_only(*names)
        instance_methods(false).each do |name|
          if /\Atest_.*/ =~ name && ([name] & names).empty?
            remove_method :"#{name}"
          end
        end
      end
    end
  end
end

# Defining new asserts
class Test::Unit::TestCase
  def assert_array(array1, array2)
    flunk "sizes are differents: #{array1.size} != #{array2.size}" \
      if array1.size != array2.size

    array1.size.times do |index|
      flunk "index=#{index}... #{array1[index]} != #{array2[index]}" \
        unless array1[index] == array2[index]
    end

    assert true
  end
end
