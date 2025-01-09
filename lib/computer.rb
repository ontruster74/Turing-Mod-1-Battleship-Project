class Computer
    attr_reader :board

    def initialize(board)
        @board = board
        @last_hit = nil
    end

    def place_ship(ship)
        coordinates = []
        while true do 
            rand_coord = @board.cells.keys.sample { |cell| @board.cells[cell] }
            horizontal = [true, false].sample

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

    def fire_upon(board)
        target_cell = nil

        if @last_hit
            north = "#{(@last_hit.coordinate[0].ord - 1).chr}#{@last_hit.coordinate[1]}"
            south = "#{(@last_hit.coordinate[0].ord + 1).chr}#{@last_hit.coordinate[1]}"
            east = "#{@last_hit.coordinate[0]}#{(@last_hit.coordinate[1].to_i + 1).to_s}"
            west = "#{@last_hit.coordinate[0]}#{(@last_hit.coordinate[1].to_i - 1).to_s}"

            adjacents = [north, south, east, west]

            successful_shot = false
            adjacents.each do |coord|
                if (board.valid_coordinate?(coord) && !(board.cells[coord].fired_upon?))
                    target_cell = board.cells[coord]
                    target_cell.fire_upon
                    successful_shot = true
                    break
                end
            end

            if !successful_shot
                @last_hit = false
                fire_upon(board)
            end
        else
            while true do
                target_cell = board.cells[board.cells.keys.sample { |cell| board.cells[cell] }]

                if !(target_cell.fired_upon?)
                    target_cell.fire_upon
                    break
                end
            end
        end

        @last_hit = target_cell if !target_cell.empty?
        target_cell
    end
end