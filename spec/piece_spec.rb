require 'spec_helper.rb'
require_relative '../piece.rb'

describe Piece do

	before(:each) do
		@piece = Piece.new(:white, [])
		@pawn = Pawn.new(:white)	
		@king = King.new(:white)
		@rook = Rook.new(:white)
		@black_pawn = Pawn.new(:black)
	end


	describe "has_moved" do
		it "should be marked as false upon initialization" do
			expect(@piece.has_moved).to eq(false)
			expect(@pawn.has_moved).to eq(false)
			expect(@king.has_moved).to eq(false)
			expect(@rook.has_moved).to eq(false)
		end
	end

	describe Pawn do
		it "should have the correct attack moves" do
			expect(@pawn.has_moved).to eq(false)
			expect(@pawn.attack_moves).to eq([[1,-1], [1,1]])		
		end

		it "should have attack moves in the opposite direction if it is black pawn" do
			expect(@black_pawn.attack_moves).to eq([[-1,-1], [-1,1]])
		end
	end
end
