class Animal
  def say
    puts 'animal'
  end
end

class Bunny < Animal
  def ears
    puts 'long'
  end
end

b = Bunny.new

puts b.singleton_methods
