class Computer
    attr_reader :board

    def initialize(board)
        @board = board
    end

    def place_ship(ship)
        coordinates = []
        while true do 
            rand_coord = @board.cells.keys.sample { |cell| @board.cells[cell] }
            horizontal = [false, false].sample

            rand_letter = rand_coord[0]
            rand_num = rand_coord[1]
            if horizontal
                rand_end = "#{rand_letter}#{rand_num.to_i + ship.length - 1}"
                coordinates = (rand_coord..rand_end).to_a
            else
                letter_array = (rand_letter..(rand_letter.ord + ship.length - 1).chr).to_a
                coordinates = letter_array.map { |letter| letter + rand_num }
            end

            break if @board.valid_placement?(ship, coordinates)
            coordinates = []
        end
        @board.place(ship, coordinates)
        return coordinates
    end
end