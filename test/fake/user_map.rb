GameMines.load('lib/user_map')

module GameMines
  # Used for tests
  class FakeUserMap < UserMap
    attr_accessor :matrix
    attr_reader :rows, :cols
  end
end
