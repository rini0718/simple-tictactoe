class Game
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
    @current_player = 'X'
    @winner = nil
  end

  def play
    loop do
      print_board
      break if game_over?

      puts "Player #{@current_player}, enter your move (1-9):"
      move = gets.chomp.to_i - 1
      make_move(move)
      switch_player
    end

    puts "Player #{@winner} wins!" if @winner
  end

  private

  def print_board
    @board.each do |row|
      puts row.join(' | ')
    end
  end

  def make_move(move)
    row = move / 3
    col = move % 3
    @board[row][col] = @current_player
  end

  def game_over?
    # Check rows, columns, and diagonals for a win
    (0..2).any? { |i| @board[i].uniq.length == 1 } ||
    (0..2).any? { |i| @board.transpose[i].uniq.length == 1 } ||
    [@board, @board.map(&:reverse)].any? { |b| b.map(&:first).uniq.length == 1 }
  rescue
    false
  end

  def switch_player
    @current_player = @current_player == 'X' ? 'O' : 'X'
  end
end

Game.new.play
