require_relative "board"

class Game
  def initialize
    @board = Board.new
  end

  def run
    until game_over?
      play_turn
    end
  end

  def game_over?
    @board.grid.flatten.all? { |tile| tile.revealed }
  end

  def play_turn
    system('cls')
    @board.display
    pos = get_move
    check_for_mines(pos)
  end

  def get_move
    while true
      puts "Where would you like to move? "
      response = gets.chomp.split(",").map(&:to_i)
      return response if is_valid?(response)
    end
  end

  def is_valid?(response)
    response.count == 2 &&
    ((0..8).include?(response[0]) && (0..8).include?(response[1]))
  end

  def check_for_mines(pos)
    puts "You hit a mine!" if @board[pos].mined
    @board[pos].revealed = true
    sleep(2)
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  game.run
end
