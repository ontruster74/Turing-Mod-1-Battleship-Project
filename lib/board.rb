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
end