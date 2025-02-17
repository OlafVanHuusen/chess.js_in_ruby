# frozen_string_literal: true
require_relative '../piece'

class Rook < Piece
  def initialize(color)
    super(color)
    @value = 5
    @move_vectors = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    @max_steps = -1
  end

  def get_char_representation
    @color == "white" ? 'R' : 'r'
  end

  def valid_move?(start_pos, end_pos, board)
    return false if start_pos == end_pos
    return false if board[end_pos[0]][end_pos[1]].color == @color
    return false if start_pos[0] != end_pos[0] && start_pos[1] != end_pos[1]
    return false unless is_path_clear?(start_pos, end_pos, board)
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
      pos += vector
      if board[pos[0]][pos[1]].nil?
        moves << pos.dup
      else
        moves << pos.dup if board[pos[0]][pos[1]].color != @color
        break
      end
    end
    moves
  end

  def is_path_clear?(start_pos, end_pos, board)
    squares = get_squares_between(start_pos, end_pos)
    squares.all? { |square| board[square[0]][square[1]].nil? }
  end

  def get_squares_between(start_pos, end_pos)
    difference = (end_pos - start_pos).normalize
    squares = []
    while (start_pos += difference) != end_pos
      squares << start_pos
    end
    squares
  end
end
