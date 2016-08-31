GameMines.load('test/test_helper')
GameMines.load('test/fake/console_menu_helper')
GameMines.load('test/fake/mock')

# Test the menu helper
# It prints something to the console, waits the user input and call a method
# on the passed object.
class TestConsoleMenuHelper < Test::Unit::TestCase
  def test_print_message
    @helper = GameMines::FakeConsoleMenuHelper.new('test')
    @helper.print_message
    assert_equal 'test', @helper.printed
  end

  def test_no_message
    @helper = GameMines::FakeConsoleMenuHelper.new
    @helper.print_message
  end

  def test_choose_option_1
    @mock = GameMines::Mock.new
    options = { op1: :test_value_true, not_loop: true }
    @helper = GameMines::FakeConsoleMenuHelper.new('test', @mock, options)
    @helper.show_with_input('1')
    assert_equal true, @mock.test_value
  end

  def test_choose_invalid_option
    @mock = GameMines::Mock.new
    options = { op1: :test_value_true, not_loop: true }
    @helper = GameMines::FakeConsoleMenuHelper.new('test', @mock, options)
    @helper.show_with_input('2')
    assert_equal false, @mock.test_value
  end
end
