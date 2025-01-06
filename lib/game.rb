class Game 
  attr_reader :computer, :player_board

  def intro
    puts "--WELCOME TO BATTLESHIP--"
    puts "Enter p to play or q to quit"
    puts

    input = gets.chomp
    puts 

    if input == "p"
      self.gameplay
      self.intro
    else
      puts self.quit
    end
  end

  def gameplay
    puts "What height would you like the board to be? Enter an integer:"
    board_height = gets.chomp.to_i
    puts

    puts "What width would you like the board to be? Enter an integer:"
    board_width = gets.chomp.to_i
    puts

    @computer = Computer.new(Board.new(board_height, board_width))
    @player_board = Board.new(board_height, board_width)

    puts "Do you want to play with custom ships? (Y/N):"
    custom_ships = gets.chomp
    puts

    ships = []

    if custom_ships == "Y"
      while true do
        puts "Enter the name of your ship:"
        ship_name = gets.chomp
        puts

        puts "Enter the length of your ship:"
        ship_length = gets.chomp.to_i
        puts

        ships << Ship.new(ship_name, ship_length)

        puts "Would you like to create another ship? (Y/N)"
        another_ship = gets.chomp
        puts

        break if another_ship != "Y"
      end
    else
      ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    end

    puts "Computer is placing ships..."
    puts
    comp_ships = ships.map {|ship| Ship.new(ship.name, ship.length)}
    comp_ships.each {|ship| @computer.place_ship(ship)}

    ships.each do |ship| 
      puts "Where would you like to place your #{ship.name}?"

      while true do
        puts @player_board.render(true)
        puts
        coordinates = []
  
        ship.length.times do
          puts "Enter a coordinate:"
          coordinates << gets.chomp
          puts
        end
  
        if @player_board.valid_placement?(ship, coordinates)
          @player_board.place(ship, coordinates)
          puts "#{ship.name} in place!"
          puts
          break
        end
  
        puts "Invalid Placement. Make sure your coordinates are on the board and in alphabetical/descending order!\n"
        puts
      end
    end

    
    puts "==========GAME START==========="
    puts

    while true do
      game_over = false
      game_over = self.turn

      if game_over
        puts "==========GAME OVER==========="
        puts
        break
      end

    end
  end

  def turn
    target = @computer.fire_upon(@player_board)
    puts "The Computer fires on #{target.coordinate}!"
    puts

    if target.empty?
      puts "Miss!"
      puts
    elsif target.ship.sunk?
      puts "Sunk!"
      puts
    else
      puts "Hit!"
      puts
    end

    if @player_board.lost_game?
      puts "The Computer wins!"
      puts
      return true
    end

    puts "Enter a coordinate to fire upon:"
    player_target = nil

    while true do
      player_target = gets.chomp
      player_target_cell = @computer.board.cells[player_target]

      if !(@computer.board.valid_coordinate?(player_target))
        puts "Invalid Coordinate!"
        puts
        next
      end

      if player_target_cell.fired_upon?
        puts "You have already fired upon this coordinate. Pick a new one!"
        puts
        next
      end

      break
    end

    player_target_cell.fire_upon

    if player_target_cell.empty?
      puts "Miss!"
      puts
    elsif player_target_cell.ship.sunk?
      puts "Sunk!"
      puts
    else
      puts "Hit!"
      puts
    end

    if @computer.board.lost_game?
      puts "You win!"
      puts
      return true
    end
    
    puts "==========PLAYER BOARD==========\n"
    puts @player_board.render(true)
    puts
   

    puts "==========COMPUTER BOARD=========="
    puts @computer.board.render
    puts
 
    return false
  end

  def quit
    return "Good-bye!"
  end
end