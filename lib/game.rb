class Game 
  attr_reader :computer, :player_board

  def intro
    @computer = Computer.new(Board.new)
    @player_board = Board.new
    puts "--WELCOME TO BATTLESHIP--"
    puts "Enter p to play or q to quit"

    input = gets

    if input == "p"
      self.gameplay
    else
      self.quit
    end
  end

  def gameplay
    while true do
      self.turn
      break if @computer.board.lost_game || @player_board.lost_game
    end
  end

  def turn
    puts "==========PLAYER BOARD=========="
    puts @player_board.render

    puts "==========COMPUTER BOARD=========="
    puts @computer.board.render

    target = @computer.fire_upon(@player_board)
    puts "The Computer fires on #{target.coordinate}!"

    if target.empty?
      puts "Miss!"
    elsif target.ship.sunk?
      puts "Sunk!"
    else
      puts "Hit!"
    end

    puts "Enter a coordinate to fire upon:"
    player_target = nil

    while true do
      player_target = gets

      if !(@computer.board.valid_coordinate?(player_target))
        puts "Invalid Coordinate!"
        next
      end

      if @computer.board.cells[player_target].fired_upon?
        puts "You have already fired upon this coordinate. Pick a new one!"
        next
      end

      break
    end

    @computer.board.fire_upon(player_target)

    if player_target.empty?
      puts "Miss!"
    elsif player_target.ship.sunk?
      puts "Sunk!"
    else
      puts "Hit!"
    end
    
  end

  def quit
    return "Good-bye!"
  end
end