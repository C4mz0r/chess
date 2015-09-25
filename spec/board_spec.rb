require 'spec_helper.rb'
require_relative '../board.rb'

describe Board do

	before(:each) do
		@chessboard = Board.new	
	end

	it "should be 8 by 8" do
		expect(@chessboard.grid.length).to eq(8)
		expect(@chessboard.grid[1].length).to eq(8) 
	end

end
