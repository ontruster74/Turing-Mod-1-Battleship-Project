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
    coordinates.each {|coordinate| return false if !(@cells[coordinate].empty?)}
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

end