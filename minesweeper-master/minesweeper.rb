require 'yaml'
require './board'

class MineSweeper

  attr_reader :board

  def self.load_game
    board = YAML.load(File.open('saved_game.txt'))
    MineSweeper.new(board)
  end

  def initialize(board = nil)
    board ? @board = board : @board = Board.new
  end

  def save_game
    saved_game = board.to_yaml
    # puts "saved game: #{saved_game}"
    new_file = File.open('saved_game.txt', 'w') do |f|
      f.puts saved_game
    end
  end

  def play
    output = true
    start_time = Time.now

    until output == false || @board.game_won?
      output = true
      display
      input = read_input
      if input[0] == 's'
        save_game
        # display
      else
        output = make_move(input)
      end
    end

    if @board.game_won?
      puts "You Win! Congrats!"
      end_time = Time.now
      total_time = end_time - start_time

      puts "Total Time: #{total_time} Seconds"

    else
      puts "Sorry buddy..."
    end

    @board.show_board
    display
  end

  private

  def make_move(input)
    move = input.first
    position = [input[1].to_i, input[2].to_i]
    tile = @board[position.first][position.last]

    tile.move(move)
  end

  def read_input
    while true
      puts "choose square to reveal(r), flag(f), or unflag(u) ex: f 1 2"
      input = gets.chomp.downcase.split
      break if input[0] == 's'
      break if valid_input?(input)
      puts "Please provide proper input"
    end

    input
  end

  def valid_input?(input)
    return false unless input.count == 3

    choice = input[0]
    nums = [input[1].to_i, input[2].to_i]

    (choice == 'f' || choice == 'u' || choice == "r") &&
    Board.valid_position?(nums)
  end

  def display
    display_board = @board.create_display_screen

    puts "_||#{(0...Board::BOARD_SIZE).to_a.join("|")}||"
    display_board.each.with_index do |row, idx|
      puts "#{idx}||" + row.join("|") + "||"
    end
  end



end

if __FILE__ == $PROGRAM_NAME
  puts "load game? (y/n)"
  game = nil
  answer = gets.chomp
  if answer == 'y'
    game = MineSweeper.load_game
  else
    game = MineSweeper.new
  end
  game.play
end
