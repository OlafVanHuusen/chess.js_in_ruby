# frozen_string_literal: true
require_relative '../piece'

class Bishop < Piece
  def initialize(color)
    super(color)
    @value = 3
    @move_vectors = [-1, 1].repeated_permutation(2).to_a
    @max_steps = -1
  end

  def get_char_representation
    @color == "white" ? 'B' : 'b'
  end

  def valid_move?(start_pos, end_pos, board)
    return false if start_pos == end_pos || board[end_pos[0]][end_pos[1]].color == @color
    return false unless board.contains_coordinate?(end_pos) && is_diagonal_move?(start_pos, end_pos) &&
      is_path_clear?(start_pos, end_pos, board)
    true
  end

  def get_all_possible_moves(start_pos, board)
    moves = []
    @move_vectors.each do |vector|
      moves.concat(get_possible_moves_in_direction(start_pos, vector, board))
    end
    moves
  end

  private

  def get_possible_moves_in_direction(start_pos, vector, board)
    moves = []
    pos = start_pos.dup
    while board.contains_coordinate?(pos)
      pos = [pos[0] + vector[0], pos[1] + vector[1]]
      if board[pos[0]][pos[1]].nil?
        moves << pos.dup
      else
        moves << pos.dup if board[pos[0]][pos[1]].color != @color
        break
      end
    end
    moves
  end

  def is_diagonal_move?(start_pos, end_pos)
    (start_pos[0] - end_pos[0]).abs == (start_pos[1] - end_pos[1]).abs
  end

  def is_path_clear?(start_pos, end_pos, board)
    squares = get_squares_between_diagonal(start_pos, end_pos)
    squares.all? { |square| board[square[0]][square[1]].nil? }
  end

  def get_squares_between_diagonal(start_pos, end_pos)
    difference = [(end_pos[0] - start_pos[0]).sign, (end_pos[1] - start_pos[1]).sign]
    squares = []
    while (start_pos += difference) != end_pos
      squares << start_pos
    end
    squares
  end
end
