# TODO: fix valid_move. wont let kings move backwards

class Piece
  BACK_ROW = { white: 7, black: 0 }
  MOVE_DIRS = { white: 1, black: -1, left: -1, right: 1 }
                              # temp debugging purposes
  attr_accessor :pos, :color, :is_king

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @is_king = false
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise InvalidMoveError
    end
  end

  def perform_moves!(move_sequence)
    p move_diffs
    if move_sequence.count > 1
      move_sequence.each do |move|
        raise InvalidMoveError unless perform_jump(move)
      end
    else
      move_sequence.each do |move|
        raise InvalidMoveError unless perform_slide(move)
      end
    end
  end

  def valid_move_seq?(move_sequence)
    test_board = board_dup
    test_piece = test_board[pos]
    begin
      test_piece.perform_moves!(move_sequence)
    rescue InvalidMoveError
      return false
    end
    true
  end

  def perform_jump(new_pos)
    return false if move_diffs.none?{ |move| move == new_pos }

    @board.remove_piece_at(caught_piece_pos(new_pos, pos))

    @board.update_board(pos, new_pos)
    self.pos = new_pos

    maybe_promote
    true
  end

  def perform_slide(new_pos)
    return false if move_diffs.none? { |move| move == new_pos}

    @board.update_board(pos, new_pos)
    self.pos = new_pos

    maybe_promote
    true
  end

  def is_king?
    @is_king
  end

  # just for debugging
  def inspect
    { pos: @pos, color: @color, is_king: false }
  end

  # private

  def board_dup
    new_board = Board.new
    @board.each_with_index do |tile, ridx, cidx|
      if tile.is_a?(Piece)
        new_piece = Piece.new(tile.pos, tile.color, new_board)
        new_piece.is_king = tile.is_king?
        new_board[[ridx, cidx]] = new_piece
      end
    end
    new_board
  end

  def maybe_promote
    puts 'yes'
    @is_king = true if self.pos[0] == BACK_ROW[color]
    p @is_king
    nil
  end

  def is_enemy?(piece)
    color != piece.color
  end

  def caught_piece_pos(new_pos, old_pos)
    new_pos.each_with_index.map do |coord, idx|
      (coord - old_pos[idx]) / 2 + old_pos[idx]
    end
  end

  # checks directions piece could move in.
  # helper method for perform_jump and perform_slide
  def move_diffs
    forwards = dirs(:forward, :left) + dirs(:forward, :right)
    backwards = dirs(:backward, :left) + dirs(:backward, :right)

    is_king? ? forwards + backwards : forwards
  end

  def dirs(vert, horiz)
    dirs = []

    one_vert_horiz = self.send(vert, 1, horiz)
    two_vert_horiz = self.send(vert, 2, horiz)

    if @board.open_square?(one_vert_horiz)
      dirs << one_vert_horiz
    elsif @board.open_square?(two_vert_horiz) &&
          self.is_enemy?(@board[one_vert_horiz])
      dirs << two_vert_horiz
    end

    dirs
  end

  def backward(mag, horiz_dir)
    horiz = MOVE_DIRS[horiz_dir]
    vert = color == :white ? MOVE_DIRS[:black] : MOVE_DIRS[:white]
    [pos, [vert * mag, horiz * vert * mag]].transpose.map { |arr| arr.reduce(&:+) }
  end

  def forward(mag, horiz_dir)
    horiz, vert = MOVE_DIRS[horiz_dir], MOVE_DIRS[color]
    [pos, [vert * mag, horiz * vert * mag]].transpose.map { |arr| arr.reduce(&:+) }
  end
end


class InvalidMoveError < StandardError
end
