GameMines.load('lib/cell')

module GameMines
  # Game map
  class MineMap
    attr_reader :rows, :cols, :bomb_quantity

    def create(rows, cols, bombs)
      return false unless rows.between?(5, 26) \
        && cols.between?(5, 26) \
        && bombs.between?(1, rows * cols - 1)

      init_matrix(rows, cols)
      put_bombs(bombs)
      calculate_around_bombs
      true
    end

    def bomb?(row, col)
      @matrix[row][col].bomb?
    end

    def counter(row, col)
      @matrix[row][col].counter
    end

    def cell(row, col)
      @matrix[row][col]
    end

    protected

    def init_matrix(rows, cols)
      @rows = rows
      @cols = cols
      @matrix = Array.new(rows) { Array.new(cols) }
      @matrix.each { |row| row.fill { Cell.new } }
    end

    def put_bombs(bombs)
      @bomb_quantity = bombs
      availables = (0...(@rows * @cols)).to_a

      bombs.times do
        chosen = availables.delete_at(Random.rand(availables.size))
        row = (chosen / @cols).to_int
        col = chosen % @cols
        @matrix[row][col].bomb!
      end
    end

    def calculate_around_bombs
      @matrix.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          increment_around(row_index, col_index) if cell.bomb?
        end
      end
    end

    private

    def increment_around(row_index, col_index)
      ((row_index - 1)..(row_index + 1)).each do |row|
        ((col_index - 1)..(col_index + 1)).each do |col|
          unless [-1, @rows].include?(row) || [-1, @cols].include?(col)
            cell = @matrix[row][col]
            cell.increment unless cell.bomb?
          end
        end
      end
    end
  end
end
