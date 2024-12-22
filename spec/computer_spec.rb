require 'rspec'
require './lib/computer'
require './lib/board'
require './lib/ship'
require './lib/cell'

describe Computer do
    before do
        @cruiser = Ship.new("Cruiser", 3)
        @board = Board.new
        @computer = Computer.new(@board)
    end

    describe "#initialize" do
        it 'exists' do
            expect(@computer).to be_a(Computer)
        end

        it 'has a board' do
            expect(@computer.board).to eq(@board)
        end
    end

    describe "#place_ship" do
        it 'can place ships' do
            coordinates = @computer.place_ship(@cruiser)

            expect(@board.valid_placement?(@cruiser, coordinates)).to eq(true)
            
            coordinates.each do |coordinate|
                expect(@board.cells[coordinate].empty?).to eq(false)
            end
        end
    end
end