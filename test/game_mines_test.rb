GameMines.load('test/test_helper')
GameMines.load('test/fake/game_mines')

# This class will recieve the user input
class TestGameMinesMain < Test::Unit::TestCase
  def setup
    @game = GameMines::FakeMain.new
  end

  def test_coordinate_to_index
    assert_equal 0, @game.fake_letter_to_index('a')
    assert_equal 1, @game.fake_letter_to_index('B')
    assert_equal 25, @game.fake_letter_to_index('z')
  end
end
