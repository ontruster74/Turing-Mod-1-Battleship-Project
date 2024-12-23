class Game 
  attr_reader :computer, :player_board

  def intro
    @computer = Computer.new(Board.new)
    @player_board = Board.new
    puts "--WELCOME TO BATTLESHIP--"
    puts "Enter p to play or q to quit"

    input = gets.chomp

    if input == "p"
      self.gameplay
      self.intro
    else
      self.quit
    end
  end

  def gameplay
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    comp_cruiser = Ship.new("Cruiser", 3)
    comp_submarine = Ship.new("Submarine", 2)

    puts "Computer is placing ships...\n"
    @computer.place_ship(comp_cruiser)
    @computer.place_ship(comp_submarine)

    puts "Where would you like to place your Cruiser?"

    while true do
      puts @player_board.render(true)
      coordinates = []

      cruiser.length.times do
        puts "Enter a coordinate:"
        coordinates << gets.chomp
      end

      if @player_board.valid_placement?(cruiser, coordinates)
        @player_board.place(cruiser, coordinates)
        puts "Cruiser in place!\n"
        break
      end

      puts "Invalid Placement. Make sure your coordinates are on the board and in alphabetical/descending order!\n"
    end

    puts "Where would you like to place your Submarine?"

    while true do
      puts @player_board.render(true)
      coordinates = []

      submarine.length.times do
        puts "Enter a coordinate:"
        coordinates << gets.chomp
      end

      if @player_board.valid_placement?(submarine, coordinates)
        @player_board.place(submarine, coordinates)
        puts "Submarine in place!\n"
        break
      end

      puts "Invalid Placement. Make sure your coordinates are on the board and in alphabetical/descending order!\n"
    end

    while true do
      game_over = false
      game_over = self.turn

      if game_over
        break
      end
      
    end
  end

  def turn
    target = @computer.fire_upon(@player_board)
    puts "The Computer fires on #{target.coordinate}!\n"

    if target.empty?
      puts "Miss!\n"
    elsif target.ship.sunk?
      puts "Sunk!\n"
    else
      puts "Hit!\n"
    end

    if @player_board.lost_game?
      puts "The Computer wins!\n"
      return true
    end

    puts "Enter a coordinate to fire upon:"
    player_target = nil

    while true do
      player_target = gets.chomp
      player_target_cell = @computer.board.cells[player_target]

      if !(@computer.board.valid_coordinate?(player_target))
        puts "Invalid Coordinate!\n"
        next
      end

      if player_target_cell.fired_upon?
        puts "You have already fired upon this coordinate. Pick a new one!\n"
        next
      end

      break
    end

    player_target_cell.fire_upon

    if player_target_cell.empty?
      puts "Miss!\n"
    elsif player_target_cell.ship.sunk?
      puts "Sunk!\n"
    else
      puts "Hit!\n"
    end

    if @computer.board.lost_game?
      puts "You win!\n"
      return true
    end
    
    puts "==========PLAYER BOARD==========\n"
    puts @player_board.render(true)
   

    puts "==========COMPUTER BOARD==========\n"
    puts @computer.board.render
 
    return false
  end

  def quit
    return "Good-bye!"
  end
end