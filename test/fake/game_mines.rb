require 'forwardable'
GameMines.load('lib/game_mines')

module GameMines
  # Used for tests
  class FakeMain < Main
    extend Forwardable

    def_delegator :self, :letter_to_index, :fake_letter_to_index
  end
end
