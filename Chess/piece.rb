class Piece
  attr_accessor :color, :pos, :board, :moved

  def initialize(color, pos, moved, board)
    @color, @pos, @moved, @board = color, pos, moved, board
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def to_s
    " X ".colorize(@color)
  end

  def move_to(pos)
    self.pos = pos
    self.moved = true
  end

  def valid_moves
    valid_moves = []
    board.size.times do |i|
      board.size.times do |j|
        valid_moves << [i, j]
      end
    end
    valid_moves.delete(pos)
    valid_moves
  end

end
