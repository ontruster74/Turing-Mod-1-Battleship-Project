require 'rspec'
require './lib/ship.rb'

describe Ship do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end

    describe '#initialize' do
        it 'exists' do
            expect(@cruiser).to be_a(Ship)
        end

        it 'has a name' do
            expect(@cruiser.name).to eq("Cruiser")
        end

        it 'has a length' do
            expect(@cruiser.length).to eq(3)
        end

        it 'has health equal to its length' do
            expect(@cruiser.health).to eq(@cruiser.length)
        end
    end

    describe '#sunk?' do
        it 'can show that a ship has not sunk' do
            expect(@cruiser.sunk?).to eq(false)
        end

        it 'can show that a ship has sunk' do
            @cruiser.hit
            @cruiser.hit
            @cruiser.hit

            expect(@cruiser.sunk?).to eq(true)
        end
    end

    describe '#hit' do
        it 'can hit a ship' do
            @cruiser.hit

            expect(@cruiser.health < 3).to eq(true)
        end
    end
end