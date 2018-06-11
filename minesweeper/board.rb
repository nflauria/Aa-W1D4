require_relative "tile"

class Board
  attr_reader :grid

  def initialize
    generate_board
  end

  def display
    @grid.each do |row|
      row.each do |tile|
        if tile.revealed && tile.mined
          print " B "
        elsif tile.revealed
          print " R "
        else
          print " X "
        end
      end
      print "\n"
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  private

  def generate_board
    @grid = Array.new(9) do |row|
      Array.new(9) { Tile.new }
    end
    place_mines
  end

  def place_mines
    already_placed = []
    i = 0
    while i < 25
      row = rand(0..8)
      col = rand(0..8)
      if !already_placed.include?([row, col])
        @grid[row][col].mined = true
        already_placed << [row, col]
        i += 1
      end
    end
  end
end
