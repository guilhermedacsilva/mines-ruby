GameMines.load('test/test_helper')
GameMines.load('test/fake/mine_map')
GameMines.load('test/fake/user_map')

# The user will interact with this map
# The map holds boolean values.
# true: the cell is openned
# false: the cell is closed
# It needs a MineMap to work.
class TestUserMap < Test::Unit::TestCase
  def setup
    @user_map = GameMines::FakeUserMap.new
    @mine_map = GameMines::FakeMineMap.new
    @mine_map.fake_init_matrix(5, 5)
    @mine_map.matrix[2][2].bomb!
    @mine_map.fake_calculate_around_bombs
    @user_map.create(@mine_map)
  end

  def test_create_user_map
    assert_equal 5, @user_map.rows
    assert_equal 5, @user_map.cols
  end

  def test_initial_state_false
    assert_equal 25, @user_map.matrix.flatten.count(false)
  end

  def test_pick_empty_cell
    assert @user_map.pick(0, 0)
    assert @user_map.matrix[0, 0]
    assert @user_map.alive?
  end

  def test_pick_counter_cell
    assert @user_map.pick(1, 1)
    assert @user_map.matrix[1, 1]
    assert @user_map.alive?
    assert_equal 1, @user_map.matrix.flatten.count(true)
  end

  def test_pick_out_of_range_cell
    refute @user_map.pick(-1, 0)
    refute @user_map.pick(0, 5)
    assert @user_map.alive?
  end

  def test_pick_bomb_cell
    assert @user_map.pick(2, 2)
    refute @user_map.alive?
  end

  def test_open_several_cells_simple
    @user_map.pick(0, 0)
    expected_array = create_simple_cells_array
    matrix = @user_map.matrix.flatten
    assert_array expected_array, matrix
  end

  def test_open_several_cells_complex
    setup_complex_mine_map
    @user_map.pick(0, 4)
    expected_array = create_complex_cells_array
    matrix = @user_map.matrix.flatten
    assert_array expected_array, matrix
  end

  def test_printed_matrix_empty
    5.times do |line|
      assert_equal '?|?|?|?|?|', @user_map.get_printed_line(line)
    end
  end

  def test_printed_matrix_open
    @user_map.pick(0, 0)
    assert_equal ' | | | | |', @user_map.get_printed_line(0)
    assert_equal ' |1|1|1| |', @user_map.get_printed_line(1)
    assert_equal ' |1|?|1| |', @user_map.get_printed_line(2)
    assert_equal ' |1|1|1| |', @user_map.get_printed_line(3)
    assert_equal ' | | | | |', @user_map.get_printed_line(4)
  end

  def test_printed_matrix_counter
    @user_map.pick(1, 1)
    assert_equal '?|?|?|?|?|', @user_map.get_printed_line(0)
    assert_equal '?|1|?|?|?|', @user_map.get_printed_line(1)
    assert_equal '?|?|?|?|?|', @user_map.get_printed_line(2)
    assert_equal '?|?|?|?|?|', @user_map.get_printed_line(3)
    assert_equal '?|?|?|?|?|', @user_map.get_printed_line(4)
  end

  def test_printed_matrix_mine
    @user_map.pick(2, 2)
    assert_equal '?|?|*|?|?|', @user_map.get_printed_line(2)
  end

  private

  def create_simple_cells_array
    [
      true, true, true, true, true,
      true, true, true, true, true,
      true, true, false, true, true,
      true, true, true, true, true,
      true, true, true, true, true
    ]
  end

  def create_complex_cells_array
    [
      false, true, true, true, true,
      false, true, true, true, true,
      false, false, false, true, true,
      false, false, false, true, true,
      false, false, false, false, false
    ]
  end

  def setup_complex_mine_map
    @mine_map.fake_init_matrix(5, 5)
    @mine_map.matrix[0][0].bomb!
    @mine_map.matrix[2][2].bomb!
    @mine_map.matrix[4][4].bomb!
    @mine_map.fake_calculate_around_bombs
    @user_map.create(@mine_map)
  end
end
