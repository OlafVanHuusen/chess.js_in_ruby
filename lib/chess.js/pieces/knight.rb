# frozen_string_literal: true
require_relative '../piece'


class Knight < Piece
  def initialize(color)
    super(color)
    @value = 3
    @move_vectors = [[1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1]]
    @max_steps = 1
  end

  def get_char_representation
    @color == 'white' ? 'N' : 'n'
  end
end
