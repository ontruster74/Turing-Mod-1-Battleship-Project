require 'rspec'
require './lib/cell'
require './lib/ship'
require './lib/board'

describe Board do
  before do
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@board).to be_a(Board)
    end
  end

  describe '#cells' do
    it 'has a board of 16 cell objects' do
      expect(@board.cells.size).to eq(16)

      @board.cells.values.each {|cell| expect(cell).to be_a(Cell)}
    end
  end

  describe '#valid_coordinate?' do
    it 'can validate coordinates' do
      expect(@board.valid_coordinate?("A1")).to eq(true)
      expect(@board.valid_coordinate?("D4")).to eq(true)
      expect(@board.valid_coordinate?("A5")).to eq(false)
      expect(@board.valid_coordinate?("E1")).to eq(false)
      expect(@board.valid_coordinate?("A22")).to eq(false)
    end
  end

  describe '#valid_placement?' do
    it 'can validate placed ship length' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"]).to eq(false))
    end

    it 'can validate consecutive coordinates' do
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"]).to eq(false))
      expect(@board.valid_placement?(@submarine, ["A1", "C1"]).to eq(false))
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"]).to eq(false))
      expect(@board.valid_placement?(@submarine, ["C1", "B1"]).to eq(false))
    end

    it 'can validate diagonal coordinates' do
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"]).to eq(false))
      expect(@board.valid_placement?(@submarine, ["C2", "D3"]).to eq(false))
    end
  end
end