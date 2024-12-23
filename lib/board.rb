class Board
  attr_reader :cells

  def initialize
    @cells = {}
    4.times do |letter|
      4.times do |number|
        @cells["#{(letter + 65).chr}#{number + 1}"] = Cell.new("#{(letter + 65).chr}#{number + 1}")
      end
    end
  end
    
  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    coordinates.each {|coordinate| return false if !@cells[coordinate] || !(@cells[coordinate].empty?)}
    return false if ship.length != coordinates.length

    range = coordinates.first..coordinates.last
    char_array = coordinates.map { |coordinate| coordinate[0] }
    char_range = char_array.first..char_array.last
    return false if range.to_a != coordinates && char_range.to_a != char_array

    num_array = coordinates.map { |coordinate| coordinate[1] }
    return num_array.all? { |num| num == num_array[0] } || char_array.all? { |char| char == char_array[0] }
  end

  def place(ship, coordinates)
    coordinates.each { |coordinate| @cells[coordinate].place_ship(ship)}
  end

  def render(show_ships = false)
    final_render = "  1 2 3 4 \n"

    if show_ships
      renders = @cells.map do |key, cell| 
        (cell.render == "." && !cell.empty?) ? "S" : cell.render
      end

      render_rows = []
      renders.each_slice(4) {|row| render_rows << row}

      4.times do |index|
        final_render << "#{(index + 65).chr}" 
        render_rows[index].each do |render|
          final_render << " #{render}"
          
        end
        final_render << " \n"
      end
    else
      renders = @cells.map{|key, cell| cell.render}
      render_rows = []
      renders.each_slice(4) {|row| render_rows << row}

      4.times do |index|
        final_render << "#{(index + 65).chr}" 
        render_rows[index].each do |render|
          final_render << " #{render}"
          
        end
        final_render << " \n"
      end
    end

    return final_render
  end

  def lost_game?
    @cells.each do |cell|
      if (!(cell[1].empty?) && !(cell[1].ship.sunk?))
        return false
      end
    end
    return true
  end

end