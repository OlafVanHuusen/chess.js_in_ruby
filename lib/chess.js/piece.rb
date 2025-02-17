# frozen_string_literal: true

class Piece

  def initialize(color)
    @color = color
    @value = nil
    @move_vectors = nil
    @max_steps = nil
  end

  def get_value
    @value
  end

  def get_color
    @color
  end

  def get_move_vectors
    @move_vectors
  end

  def get_max_steps
    @max_steps
  end

  def get_char_representation
    raise NotImplementedError
  end

end
