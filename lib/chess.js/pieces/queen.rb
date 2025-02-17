# frozen_string_literal: true
require_relative '../piece'

class Queen < Piece
  def initialize(color)
    super(color)
    @value = 9
    @move_vectors = [[1, 1], [1, -1], [-1, 1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    @max_steps = -1
  end

  def get_char_representation
    @color == 'white' ? 'Q' : 'q'
  end
end
