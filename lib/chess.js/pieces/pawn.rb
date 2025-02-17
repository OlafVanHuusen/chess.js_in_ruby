# frozen_string_literal: true
require_relative '../piece'

class Pawn < Piece
  def initialize(color)
    super(color)
    @value = 1
    @move_vectors = color == 'white' ? [[-1, 0], [-2, 0], [-1, -1], [-1, 1]] : [[1, 0], [2, 0], [1, -1], [1, 1]]
    @max_steps = 1
  end

  def get_char_representation
    @color == 'white' ? 'P' : 'p'
  end
end
