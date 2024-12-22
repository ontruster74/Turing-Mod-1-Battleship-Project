class Game 
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
      
    end
  end

  def turn
    
  end

  def quit
    return "Good-bye!"
  end
end