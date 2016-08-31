GameMines.load('test/test_helper')
GameMines.load('test/fake/mine_map')

# The map should be able to create a map for the game.
# The use can choose how many rows, coluns and bombs the map will have.
# The max value for rows and coluns is 26. The min value is 5.
# The bombs min value is 1 and max is rows*cols-1
class TestMineMap < Test::Unit::TestCase
  def setup
    @map = GameMines::FakeMineMap.new
  end

  def test_create_map_arguments
    refute @map.create(4, 10, 1)
    refute @map.create(10, 4, 1)
    assert @map.create(5, 5, 1)
    assert @map.create(26, 26, 675) # 26 * 26 - 1 = 675
    refute @map.create(27, 10, 1)
    refute @map.create(10, 27, 1)
    refute @map.create(10, 10, 676) # 26 * 26 = 676
  end

  def test_create_map_matrix
    @map.create(10, 10, 50)
    assert_equal 10, @map.matrix.size
    assert_equal 100, @map.matrix.flatten.size
  end

  def test_count_bombs
    @map.create(5, 5, 5)
    assert_equal 5, count_bombs_from_matrix
    assert_equal 20, count_safes_from_matrix

    @map.create(5, 5, 24)
    assert_equal 24, count_bombs_from_matrix
    assert_equal 1, count_safes_from_matrix
  end

  def test_counters_around_bombs_simple
    expected_array = create_simple_expected_array
    @map.fake_init_matrix(5, 5)
    @map.matrix[2][2].bomb!
    @map.fake_calculate_around_bombs
    matrix = @map.matrix.flatten
    expected_array.each_with_index do |expected, index|
      assert_equal expected, matrix[index].counter if expected != -1
    end
  end

  def test_counters_around_bombs_complex
    expected_array = create_complex_expected_array
    setup_complex_map
    matrix = @map.matrix.flatten
    expected_array.each_with_index do |expected, index|
      assert_equal expected, matrix[index].counter if expected != -1
    end
  end

  private

  def count_bombs_from_matrix
    @map.matrix.flatten.select(&:bomb?).size
  end

  def count_safes_from_matrix
    @map.matrix.flatten.reject(&:bomb?).size
  end

  def create_simple_expected_array
    [
      0, 0, 0, 0, 0,
      0, 1, 1, 1, 0,
      0, 1, -1, 1, 0,
      0, 1, 1, 1, 0,
      0, 0, 0, 0, 0
    ]
  end

  def create_complex_expected_array
    [
      -1, 1, 0, 1, -1,
      3, 4, 3, 4, 3
    ]
  end

  # B 1 0 1 B
  # 3 4 3 4 3
  # B B B B B
  def setup_complex_map
    @map.fake_init_matrix(3, 5)
    @map.matrix[0][0].bomb!
    @map.matrix[0][4].bomb!
    5.times { |n| @map.matrix[2][n].bomb! }
    @map.fake_calculate_around_bombs
  end
end
