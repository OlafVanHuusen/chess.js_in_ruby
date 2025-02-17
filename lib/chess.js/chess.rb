# frozen_string_literal: true
require_relative 'pieces/rook'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'piece'

class Chess

  DEFAULT_POSITION = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  ALPHABET = ('a'..'z').to_a
  # lowercase for black pieces
  # Both Arrays have to have the same dimensions and have to be rectangular
  def initialize(fen = DEFAULT_POSITION)
    @board = board_from_fen(fen)
    @length = @board[0].length
    @height = @board.length
    @squares = create_squares
    @moves = []
    @turn = 'white'
    #store infos like loggedMovesSinceStart, castlingRights, enPassantSquare, halfmoveClock, fullmoveNumber add update methods accordingly
  end

  def get_piece_at(coordinate)
    @board[coordinate[0]][coordinate[1]]
  end

  def get_square_at(coordinate)
    @squares[coordinate[0]][coordinate[1]]
  end


  def get_coordinates_of(square)
    x = ALPHABET.index(square[0])
    y = square[1].to_i - 1
    [y, x]
  end

  def board_from_fen(fen)
    fen_parts = fen.split(' ')
    rows = fen_parts[0].split('/')
    board = Array.new(rows.length) { [] }
    rows.each_with_index do |row, index|
      row.chars.each do |char|
        if (match = char.match(/\d+/))
          empty_squares = match[0].to_i
          empty_squares.times do |i|
            board[index] << nil
          end
        else
          board[index] << create_piece(char)
        end
      end
    end
    board
  end

  def create_squares
    squares = []
    @height.downto(1).map do |i|
      line = []
      (0..@length - 1).map do |j|
        line << ALPHABET[j] + i.to_s
      end
      squares << line
    end
    squares
  end

  def clear
    @board = [[' ' * @length] * @height]
  end

  def fen
    fen = ''
    (0..@height - 1).each do |i|
      empty = 0
      @board[i].each do |square|
        if square == nil
          empty += 1
        else
          fen += empty.to_s if empty > 0
          empty = 0
          fen += square.get_char_representation
        end
      end
      fen += empty.to_s if empty > 0
      fen += '/' unless i == 0
    end
    #TODO add turn, castling rights, en passant square, halfmove clock, fullmove number
    fen
  end

  def get(square)
    get_piece_at(get_coordinates_of(square))
  end

  def ascii
    output = "   +" + "-" * @length * 3 + "+\n"
    lines = @board.map.with_index do |row, i|
      "#{@height - i}  | #{row * ' | '} |\n"
    end
    output += lines.join("   +" + "-" * @length * 3 + "+\n")
    output += "   +" + "-" * @length * 3 + "+\n"
    output += "     a  b  c  d  e  f  g  h\n"

  end

  #@param [String] square - the square to put the piece on
  # @param [Piece] piece - usage new Pawn('white') for example
  def put(piece, square)
    coordinate = get_coordinates_of(square)
    @board[coordinate[0]][coordinate[1]] = piece
  end

  def remove(square)
    coordinates = get_coordinates_of(square)
    temp = @board[coordinates[0]][coordinates[1]]
    @board[coordinates[0]][coordinates[1]] = nil
    temp
  end

  def reset
    @board = board_from_fen(DEFAULT_POSITION)
    @length = @board[0].length
    @height = @board.length
    @squares = create_squares
    @moves = []
    @turn = 'white'
  end

  def square_color(square)
    coordinates = get_coordinates_of(square)
    (coordinates[0] + coordinates[1]).even? ? 'white' : 'black'
  end

  def turn
    @turn
  end

  def get_length
    @length
  end

  def get_height
    @height
  end

  def contains_coordinate?(coordinate)
    coordinate[0].between?(0, @length - 1) && coordinate[1].between?(0, @height - 1)
  end

  private

  def validate_dimensions(squares, board)
    unless squares.length == board.length && squares.all? { |row| row.length == board[0].length }
      raise 'Squares and board have to have the same dimensions'
    end
    unless squares.all?{ |row| row.length == squares[0].length }
      raise 'board has to be rectangular'
    end
  end

  def create_piece(char)
    case char
    when 'p'
      Pawn.new('black')
    when 'P'
      Pawn.new('white')
    when 'n'
      Knight.new('black')
    when 'N'
      Knight.new('white')
    when 'b'
      Bishop.new('black')
    when 'B'
      Bishop.new('white')
    when 'r'
      Rook.new('black')
    when 'R'
      Rook.new('white')
    when 'q'
      Queen.new('black')
    when 'Q'
      Queen.new('white')
    when 'k'
      King.new('black')
    when 'K'
      King.new('white')
    else
      raise 'Invalid character'
    end
  end
end
