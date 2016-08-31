module GameMines
  # It does the loop stuff for console interaction
  class ConsoleMenuHelper
    # options keys must start with "op"
    # "op1" is the option choosed if the user send "1"
    # options: not_loop
    def initialize(message = nil, caller = nil, options = {})
      @message = message
      @caller = caller
      @options = options
      @should_loop = options.nil? || !options.key?(:not_loop)
    end

    def show
      if @should_loop
        run_loop
      else
        run
      end
    end

    protected

    def run_loop
      while run; end
    end

    def run
      print_message
      read_chomp
      if selected_any?
        return false if should_exit?
        call_method
      end
      true
    end

    def print_message
      print @message if @message
    end

    def read_chomp
      @user_input = gets.chomp
    end

    def selected_any?
      return if @options.nil?
      @options.each do |key, value|
        if remove_prefix(key) == @user_input
          @method_name = value
          return true
        end
      end
      false
    end

    def remove_prefix(symbol)
      text = symbol.to_s
      if text.start_with?('op')
        text[2..-1]
      else
        text
      end
    end

    def call_method
      return if @caller.nil?
      @caller.send(@method_name)
    end

    def should_exit?
      @method_name.to_s == 'exit'
    end
  end
end
