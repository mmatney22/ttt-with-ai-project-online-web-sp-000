class Game

  attr_accessor :board, :player_1, :player_2, :token, :user_input

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def current_player
    @board.turn_count % 2 == 0 ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.detect do |winner|
     @board.cells[winner[0]] == @board.cells[winner[1]] &&
     @board.cells[winner[1]] == @board.cells[winner[2]] &&
     (@board.cells[winner[0]] == "X" || @board.cells[winner[0]] == "O")
     end
   end

  def draw?
      @board.full? && !won?
  end

  def over?
     won? || draw?
  end

  def winner
    if winning_combo = won?
      @winner = @board.cells[winning_combo.first]
      @winner
    end
  end

  def turn
    puts "Please enter a number between 1-9:"
    @user_input = current_player.move(@board)
    if @board.valid_move?(@user_input)
      @board.update(@user_input, current_player)
    else
      puts "Whoops! That's not a valid move."
      turn
    end
    @board.display
  end

  def play
    turn until over?
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end

end
