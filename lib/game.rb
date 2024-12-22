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
    
  end

  def quit
    
  end
end