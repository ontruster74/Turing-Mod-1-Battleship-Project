require 'rspec'
require './lib/computer'
require './lib/board'
require './lib/ship'
require './lib/cell'

describe Computer do
    before do
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
end