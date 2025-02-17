# test/board_spec.rb
require 'rspec'
require_relative '../lib/chess.js/chess'

RSpec.describe Chess do

  describe '#initialize' do
    it 'initializes with standard squares and board' do
      chess = Chess.new('rnbqkbnrRR/ppppppppRR/8RR/8RR/8RR/8RR/PPPPPPPPRR/RNBQKBNRRR w KQkq - 0 1')
      print chess.create_squares
    end

  end
end