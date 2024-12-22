class Game 
  attr_reader :computer, :player_board

  def initialize
    @computer = Computer.new(Board.new)
    @player_board = Board.new
  end

  def intro
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
      break if @computer.lost_game || @player_board.lost_game
    end
  end

  def turn
    puts "==========PLAYER BOARD=========="
    puts @player_board.render
    puts "==========COMPUTER BOARD=========="
    puts @computer.board.render
    target = @computer.fire_upon(@player_board).coordinate
    puts "The Computer fires on #{target}!"
    puts "Enter a coordinate to fire upon:"
    while true do
      
    end
    
  end

  def quit
    return "Good-bye!"
  end
end