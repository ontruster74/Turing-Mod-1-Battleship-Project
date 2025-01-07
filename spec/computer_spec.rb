require 'rspec'
require './lib/computer'
require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

describe Computer do
    before do
        @cruiser = Ship.new("Cruiser", 3)
        @board = Board.new(4, 4)
        @player_board = Board.new(4, 4)
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

            expect(Board.new(4, 4).valid_placement?(@cruiser, coordinates)).to eq(true)

            coordinates.each do |coordinate|
                expect(@board.cells[coordinate].empty?).to eq(false)
            end
        end
    end

    describe "#fire_upon" do
        it 'can fire upon a random cell' do
            target = @computer.fire_upon(@player_board)

            expect(target.fired_upon?).to eq(true)
        end

        it 'will not fire upon the same cell twice' do
            16.times do
                @computer.fire_upon(@player_board)
            end

            @player_board.cells.each do |cell|
              expect(cell[1].fired_upon?).to eq(true)
            end
        end

        it 'will fire on an adjacent space when scoring a hit' do
            battleship = Ship.new("Battleship", 4)
            @board.place(battleship, ["A1", "A2", "A3", "A4"])
            @board.place(battleship, ["B1", "B2", "B3", "B4"])
            @board.place(battleship, ["C1", "C2", "C3", "C4"])
            @board.place(battleship, ["D1", "D2", "D3", "D4"])
            
            target = @computer.fire_upon(@board)

            north = "#{(target.coordinate[0].ord - 1).chr}#{target.coordinate[1]}"
            south = "#{(target.coordinate[0].ord + 1).chr}#{target.coordinate[1]}"
            east = "#{target.coordinate[0]}#{(target.coordinate[1].to_i + 1).to_s}"
            west = "#{target.coordinate[0]}#{(target.coordinate[1].to_i - 1).to_s}"
            adjacents = [north, south, east, west]

            target2 = @computer.fire_upon(@board)
            expect(adjacents.include?(target2.coordinate)).to eq(true)

        end

    end

end