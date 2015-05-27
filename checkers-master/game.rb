require './board'

class Game


  def initialize
    @player1 = Player.new(:white)
    @player2 = Player.new(:black)
    @board = Board.test_board
    @opponent_of = {
      @player1 => @player2,
      @player2 => @player1
      }
  end

  def render
    @board.render.each_with_index do |row, idx|
      puts "#{idx} #{row}"
    end
    puts "  0 1 2 3 4 5 6 7"
  end

  def play
    cur_player = @player1
    loop do
      render
      puts "#{cur_player.color} to move"
       input = cur_player.get_input
       from = input[0]
       p input
       move_seq = input[1]
      # p from
      piece = @board[from]
      # p piece
      if !piece.is_a?(Piece) || piece.color != cur_player.color
        puts "bad input. try again"
        next
      else
          puts "stuff: #{move_seq}"
        begin
          piece.perform_moves(move_seq)
          puts 'hello world'
        rescue
          puts "invalid move, try again"
          next
        end
      end

      puts cur_player.color
      puts @opponent_of[cur_player].color
      cur_player = @opponent_of[cur_player]
    end
  end

end


class Player
  attr_accessor :color
  def initialize(color)
    @color = color
  end

  def get_input
    input = []
    puts "where would you like to move from?"
    begin
      input << gets.chomp.split(', ').map { |el| Integer(el) }
    rescue ArgumentError
      puts "Invalid input. try again"
      retry
    end

    puts "enter move sequence"
    begin
      input << gets.chomp.split(' ').map do |el|
        puts el
        el.split(',').map { |num| Integer(num) }
      end
    rescue ArgumentError
      puts "Invalid input. try again"
      retry
    end
    input
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
