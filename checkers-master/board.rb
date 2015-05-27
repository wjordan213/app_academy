require './pieces'

class Board
  def self.on_board?(pos)
    pos.all? { |num| num.between?(0, 7) }
  end

  def self.test_board
    board = Board.new
    board[[1, 1]] = Piece.new([1,1], :black, board)
    board[[6, 6]] = Piece.new([6, 6], :white, board)
    board
  end

  def self.starting_board
    board = Board.new
    board.populate
    board
  end

  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](pos)
    @board[pos[0]][pos[1]]
  end

  # just for debugging
  def []=(pos, piece)
    @board[pos[0]][pos[1]] = piece
  end

  def open_square?(pos)
    @board[pos[0]][pos[1]].nil? && Board.on_board?(pos)
  end

  def pieces
    @board.map { |el| el.select { |square| square.is_a?(Piece) } }.flatten
  end

  def remove_piece_at(pos)
    self[pos] = nil
  end

  def update_board(old_pos, new_pos)
    self[new_pos] = self[old_pos]
    self[old_pos] = nil
  end

  def each_with_index(&prc)
    @board.each_with_index do |row, ridx|
      row.each_with_index do |tile, cidx|
        prc.call(tile, ridx, cidx)
      end
    end
  end

  def populate
    fill_white_ranks
    fill_black_ranks
  end

  def render
    @board.map do |row|
      row.map do |tile|
        if tile.is_a?(Piece)
          tile.color == :black ? 'b' : 'w'
        else
          '_'
        end
      end.join('|')
    end
  end

  private

  def fill_white_ranks
    3.times do |row|
      8.times do |square|
        if row.even?
          if square.even?
            @board[row][square] = Piece.new([row, square], :white, self)
          end
        elsif square.odd?
          @board[row][square] = Piece.new([row, square], :white, self)
        end
      end
    end
  end

  def fill_black_ranks
    3.times do |row|
      8.times do |square|
        if row.odd?
          if square.even?
            @board[7 - row][square] = Piece.new([7 - row, square], :black, self)
          end
        elsif square.odd?
          @board[7 - row][square] = Piece.new([7 - row, square], :black, self)
        end
      end
    end
  end
end
