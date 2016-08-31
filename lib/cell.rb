GameMines.load('lib/util/attr_boolean')

module GameMines
  # Cell used in game matrix
  class Cell
    include GameMines::AttrBoolean

    attr_boolean :bomb
    attr_reader :counter

    def initialize
      @counter = 0
    end

    def increment
      @counter += 1
    end

    def to_s
      if bomb?
        '*'
      elsif @counter == 0
        ' '
      else
        @counter.to_s
      end
    end
  end
end
