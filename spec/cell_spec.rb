require 'rspec'
require './lib/cell.rb'
require './lib/ship.rb'

describe Cell do
  before do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_a(Cell)
    end

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end

    it 'can tell whether it contains a ship' do
      expect(@cell.ship).to eq(nil)
    end
  end

  describe '#empty?' do
    it 'can tell if it is empty' do
      expect(@cell.empty).to eq(true)
    end
  end

  describe '#place_ship' do
    it 'can place a ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end

  describe '#fire_upon' do
    it 'can be fired upon' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
    end

    it 'can be fired upon when empty' do
      @cell.fire_upon

      expect(@cell.empty?).to eq(true)
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe '#fired_upon?' do
    it 'tracks if it has been fired upon' do
      @cell.fire_upon

      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe '#render' do
    it 'can render cell' do
      expect(@cell.render).to eq(".")
    end
  end
end