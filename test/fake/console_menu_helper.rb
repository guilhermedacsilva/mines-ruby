GameMines.load('lib/util/console_menu_helper')

module GameMines
  # Used for tests
  class FakeConsoleMenuHelper < ConsoleMenuHelper
    attr_accessor :printed

    def show_with_input(input)
      @user_input = input
      show
    end

    def read_chomp
      @user_input
    end

    def print_message
      @printed = @message
    end
  end
end
