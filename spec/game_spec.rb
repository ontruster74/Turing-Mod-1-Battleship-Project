require 'rspec'
require './lib/board'
require './lib/cell'
require '/lib/ship'
require './lib/computer'
require './lib/game'
require 'pry'

describe Game do
  before do
    @game = Game.new
    @board = Board.new
  end

  describe '#initalize' do
    it 'exists' do
      expect(@game.computer).to be_a(Computer)
      expect(@game.player_board).to be_a(Board)
    end
  end

  

end