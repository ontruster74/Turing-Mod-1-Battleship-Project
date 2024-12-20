require 'rspec'
require './lib/cell'
require './lib/ship'
require './lib/board'

describe Board do
  before do
    @board = Board.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@board).to be_a(Board)
    end

  end
end