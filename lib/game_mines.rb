require File.expand_path('util/loader', __dir__)
GameMines.load('lib/mine_map')
GameMines.load('lib/user_map')
GameMines.load('lib/util/console_menu_helper')
GameMines.load('lib/util/console_color')
GameMines.load('lib/util/forwardable_with_params')

module GameMines
  # Run start to play
  class Main
    extend GameMines::ForwardableWithParams

    MESSAGE_MAIN_MENU = "Main menu\n1 - play\n2 - exit\n> ".freeze
    MESSAGE_DIFFICULT_MENU = "Choose the difficult\n" \
              "1 - easy\n2 - medium\n3 - hard\nother - back\n> ".freeze

    def_delegator_with_params :self, :play, :play_easy, [10, 10, 10]
    def_delegator_with_params :self, :play, :play_medium, [15, 15, 20]
    def_delegator_with_params :self, :play, :play_hard, [26, 26, 150]
    def_delegator_with_params :@menu_helper_initial, :show, :start
    def_delegator_with_params :@menu_helper_difficult, :show, :menu_difficult

    def initialize
      @menu_helper_initial = GameMines::ConsoleMenuHelper.new(
        MESSAGE_MAIN_MENU, self, op1: :menu_difficult, op2: :exit
      )
      @menu_helper_difficult = GameMines::ConsoleMenuHelper.new(
        MESSAGE_DIFFICULT_MENU,
        self,
        not_loop: true, op1: :play_easy, op2: :play_medium, op3: :play_hard
      )
    end

    protected

    def play(rows, cols, bombs)
      mine_map = MineMap.new
      mine_map.create(rows, cols, bombs)
      @user_map = UserMap.new
      @user_map.create(mine_map)
      loop do
        show_interface
        ask_user
        break if win_loose?
      end
    end

    def show_interface
      puts '==================='
      print_line_with_letter_indexs
      @user_map.rows.times { |index| print_line_with_cells(index) }
      print "\n"
      print_line_with_letter_indexs
    end

    def print_line_with_letter_indexs
      print '  |'
      @user_map.cols.times do |index|
        print index_to_letter(index), '|'
      end
      print "\n\n"
    end

    def index_to_letter(index)
      (index + 97).chr
    end

    def print_line_with_cells(index)
      letter = index_to_letter(index)
      printf "%s %s %s\n",
             letter,
             colored_line(@user_map.get_printed_line(index)),
             letter
    end

    def ask_user
      loop do
        print '> row: '
        row = read_index_input
        print '> col: '
        col = read_index_input
        return if @user_map.pick(row, col)
        puts 'Invalid row or col.'
      end
    end

    def read_index_input
      letter_to_index(read_char)
    end

    def read_char
      gets[0]
    end

    def letter_to_index(letter)
      index = 0
      letter.downcase.each_byte { |ascii| index = ascii - 97 }
      index
    end

    def win_loose?
      if !@user_map.alive?
        puts 'You lost!'
        true
      elsif @user_map.won?
        puts 'You won!'
        true
      else
        false
      end
    end

    def colored_line(text)
      '|' + text.gsub('?', colored_question_mark)
    end

    def colored_question_mark
      GameMines::ConsoleColor.colorize('?', 36)
    end
  end
end
