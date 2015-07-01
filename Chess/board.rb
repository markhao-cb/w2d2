require_relative 'display'
require_relative 'empty_square'
require_relative 'piece'
require 'colorize'
require 'byebug'
class Board

  attr_accessor :display, :size, :current_player
  attr_reader :grid, :cursor_position

  def initialize(size)
    @grid = Array.new(size) { Array.new(size) {EmptySquare.new} }
    @size = size
    @display = Display.new(size)
    @cursor_position = @display.cursor_position
    @current_player = :white
  end

  def play
    until game_over
      take_turns
    end
  end

  def setup_test_board
    piece = Piece.new(:white, [0,0], false, self)
    self[0,0] = piece
    render
  end

  def setup_real_board
  end
  
  private

  def [](row,col)
    @grid[row][col]
  end

  def []=(row, col, piece)
    @grid[row][col] = piece
  end

  def get_start_and_end_pos
    start_pos = get_selection
    end_pos = get_selection
    [start_pos, end_pos]
  end

  def take_turns
    start_pos, end_pos = get_start_and_end_pos
    if valid?(start_pos, end_pos)
      place_piece(start_pos, end_pos)
      switch_player
      render
    else
      get_start_and_end_pos
    end
  end

  def switch_player
    self.current_player = (self.current_player == :white) ? (:black) : (:white)
  end

  def place_piece(start_pos, end_pos)
    selected_piece = self[*start_pos]
    self[*end_pos] = selected_piece
    selected_piece.move_to(end_pos)
    clear_square(start_pos)
  end

  def clear_square(start_pos)
    self[*start_pos] = EmptySquare.new
  end

  def valid?(start_pos, end_pos)
    piece = self[*start_pos]
    valid_start_pos?(piece, start_pos) && valid_end_pos?(piece, end_pos)
  end

  def occupied?(pos)
    self[*pos].piece?
  end


  def valid_start_pos?(piece, start_pos)
    occupied?(start_pos) && current_player == piece.color
  end

  def valid_end_pos?(piece, end_pos)
    valid_moves = piece.valid_moves
    valid_moves.include?(end_pos)
  end

  def colorize_pos(i,j)
    (i + j).even? ? :red : :black
  end

  def render
    system "clear"
    puts "It is #{self.current_player.to_s}'s turn."
    self.grid.each_with_index do |row, row_idx|
      print_row = ""
      row.each_with_index do |square, square_idx|
        square_color = colorize_pos(row_idx, square_idx)
        if [row_idx, square_idx] == display.cursor_position
          square_color = :yellow
        end
        print_square = square.to_s.colorize(background: square_color)
        print_row << print_square
      end
      puts print_row
    end
  end

  def get_selection
    @display.unclick
    until @display.clicked?
      @display.get_movement
      self.render
    end
    display.cursor_position
  end

end

board = Board.new(8)
board.setup_test_board
board.take_turns
board.take_turns
board.take_turns
board.take_turns
board.take_turns
