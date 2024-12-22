require 'rspec'
require './lib/computer'
require './lib/board'
require './lib/ship'
require './lib/cell'

describe Computer do
    before do
        @computer = Computer.new
    end

    describe "#initialize" do
        it 'exists' do
            expect(@computer).to be_a(Computer)
        end
    end
end