class Computer
    attr_reader :board

    def initialize(board)
        @board = board
        @last_hit = false
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

        while true do
            rand_cell = nil

            if @last_hit
              north = "#{(@last_hit.coordinate[0].ord - 1).chr}#{@last_hit.coordinate[1]}"
              south = "#{(@last_hit.coordinate[0].ord + 1).chr}#{@last_hit.coordinate[1]}"
              east = "#{@last_hit.coordinate[0]}#{(@last_hit.coordinate[1].to_i + 1).to_s}"
              west = "#{@last_hit.coordinate[0]}#{(@last_hit.coordinate[1].to_i - 1).to_s}"

              adjacents = [north, south, east, west].shuffle  

              successful_fire = false

              adjacents.each do |coord|  
                if (board.valid_coordinate?(coord) && !(board.cells[coord].fired_upon?))
                  rand_cell = board.cells[coord]
                  rand_cell.fire_upon
                  successful_fire = true
                  break
                end
              end

              binding.pry
              if !successful_fire
                @last_hit = false
              end

            else
                rand_cell = board.cells[board.cells.keys.sample { |cell| board.cells[cell] }]
                
                if !(rand_cell.fired_upon?)
                    rand_cell.fire_upon
                    break
                end
            end
        end

        if rand_cell.ship
            @last_hit = rand_cell
        end

        rand_cell
    end
end