require 'forwardable'
GameMines.load('lib/mine_map')

module GameMines
  # Used for tests
  class FakeMineMap < MineMap
    extend Forwardable

    attr_accessor :matrix
    def_delegator :self, :init_matrix, :fake_init_matrix
    def_delegator :self, :calculate_around_bombs, :fake_calculate_around_bombs
  end
end
