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
    " \u{2657}  "
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

class Pawn < Piece

  attr_accessor :color, :pos, :board, :moved

  def initialize(color, pos, moved, board)
    super(color, pos, moved, board)
  end

  def to_s
    self.color == :white ? " \u{2659}  " : " \u{265F}  "
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
