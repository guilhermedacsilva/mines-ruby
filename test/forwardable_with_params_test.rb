GameMines.load('test/test_helper')
GameMines.load('test/fake/person_with_delegator')

# Test the forwardable with fixed params
class TestForwardableWithParams < Test::Unit::TestCase
  def setup
    @person = GameMines::PersonWithDelegator.new
  end

  def test_forwardable_array_param
    assert_equal 20, @person.ret_val_array_20
  end

  def test_forwardable_int_param
    assert_equal 20, @person.ret_val_int_20
  end
end
