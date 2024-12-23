class Game 
  attr_reader :computer, :player_board

  def intro
    @computer = Computer.new(Board.new)
    @player_board = Board.new
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
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    comp_cruiser = Ship.new("Cruiser", 3)
    comp_submarine = Ship.new("Submarine", 2)

    puts "Computer is placing ships..."
    puts
    @computer.place_ship(comp_cruiser)
    @computer.place_ship(comp_submarine)

    puts "Where would you like to place your Cruiser?"
    puts

    while true do
      puts @player_board.render(true)
      puts
      coordinates = []

      cruiser.length.times do
        puts "Enter a coordinate:"
        coordinates << gets.chomp
        puts
      end

      if @player_board.valid_placement?(cruiser, coordinates)
        @player_board.place(cruiser, coordinates)
        puts "Cruiser in place!"
        puts
        break
      end

      puts "Invalid Placement. Make sure your coordinates are on the board and in alphabetical/descending order!\n"
      puts
    end

    puts "Where would you like to place your Submarine?"
    puts

    while true do
      puts @player_board.render(true)
      puts
      coordinates = []

      submarine.length.times do
        puts "Enter a coordinate:"
        coordinates << gets.chomp
        puts
      end

      if @player_board.valid_placement?(submarine, coordinates)
        @player_board.place(submarine, coordinates)
        puts "Submarine in place!"
        puts
        break
      end

      puts "Invalid Placement. Make sure your coordinates are on the board and in alphabetical/descending order!\n"
      puts
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