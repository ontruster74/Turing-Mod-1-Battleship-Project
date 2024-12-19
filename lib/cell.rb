class Cell
  attr_reader :coordinate, :ship, :empty

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
  end

  def fire_upon
    if !empty?
      @ship.hit
    end

    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render 
    if !@fired_upon
      "."
    elsif @ship.sunk?
      "X"
    elsif @empty
      "M"
    else
      "H"
    end
  
    
  end
end