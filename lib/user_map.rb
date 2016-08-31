module GameMines
  # The map holds the user picks and if he is alive
  class UserMap
    attr_reader :rows, :cols

    def create(mine_map)
      @alive = true
      @mine_map = mine_map
      @rows = mine_map.rows
      @cols = mine_map.cols
      @matrix = Array.new(@rows) { Array.new(@cols, false) }
    end

    # return false if cannot be picked
    def pick(row, col)
      return false if invalid_or_visited_cell?(row, col)

      if @mine_map.bomb?(row, col)
        @alive = false
        @matrix[row][col] = true
      else
        open_cells_recursively(row, col)
      end

      true
    end

    def alive?
      @alive
    end

    def won?
      @matrix.flatten.count(false) == @mine_map.bomb_quantity
    end

    # ?: closed / nobody knows
    #  : 0 mines around
    # 1..9: mines around
    # *: hit mine
    def get_printed_line(row_index)
      printed = ''
      @matrix[row_index].each_with_index do |picked, col_index|
        printed +=
          if picked
            @mine_map.cell(row_index, col_index).to_s + '|'
          else
            '?|'
          end
      end
      printed
    end

    private

    def open_cells_recursively(row, col)
      return if invalid_or_visited_or_bomb_cell?(row, col)
      @matrix[row][col] = true
      return if @mine_map.counter(row, col) > 0
      ((row - 1)..(row + 1)).each do |row_offset|
        ((col - 1)..(col + 1)).each do |col_offset|
          open_cells_recursively(row_offset, col_offset)
        end
      end
    end

    def invalid_or_visited_cell?(row, col)
      !row.between?(0, @rows - 1) \
        || !col.between?(0, @cols - 1) \
        || @matrix[row][col] \
    end

    def invalid_or_visited_or_bomb_cell?(row, col)
      invalid_or_visited_cell?(row, col) || @mine_map.bomb?(row, col)
    end
  end
end
