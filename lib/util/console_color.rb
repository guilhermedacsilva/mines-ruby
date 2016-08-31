# It includes the class method "attr_boolean :name"
module GameMines
  # Can change the console's text color
  class ConsoleColor
    def self.colorize(text, color_code)
      "\e[#{color_code}m#{text}\e[0m"
    end
  end
end
