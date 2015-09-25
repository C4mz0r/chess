require 'spec_helper.rb'
require_relative '../manager.rb'

describe Manager do
	before(:each) do
		@man = Manager.new
	end

	describe "#initialize" do
		it "should render initial board with all pieces in correct places" do			

			# Black Rooks
			expect(@man.chessboard.grid[0][0].class.to_s).to eq("Rook")
			expect(@man.chessboard.grid[0][0].color).to eq(:black)

			expect(@man.chessboard.grid[0][7].class.to_s).to eq("Rook")
			expect(@man.chessboard.grid[0][7].color).to eq(:black)

			# Black Knights
			expect(@man.chessboard.grid[0][1].class.to_s).to eq("Knight")
			expect(@man.chessboard.grid[0][1].color).to eq(:black)

			expect(@man.chessboard.grid[0][6].class.to_s).to eq("Knight")
			expect(@man.chessboard.grid[0][6].color).to eq(:black)


			# Black King
			expect(@man.chessboard.grid[0][4].class.to_s).to eq("King")
			expect(@man.chessboard.grid[0][4].color).to eq(:black)

			# Black Pawns
			0.upto(7) do |i|
				expect(@man.chessboard.grid[1][i].class.to_s).to eq("Pawn")
				expect(@man.chessboard.grid[1][i].color).to eq(:black)
			end

			# Black Bishop
			expect(@man.chessboard.grid[0][2].class.to_s).to eq("Bishop")
			expect(@man.chessboard.grid[0][2].color).to eq(:black)

			expect(@man.chessboard.grid[0][5].class.to_s).to eq("Bishop")
			expect(@man.chessboard.grid[0][5].color).to eq(:black)

			# Black Queen
			expect(@man.chessboard.grid[0][3].class.to_s).to eq("Queen")
			expect(@man.chessboard.grid[0][3].color).to eq(:black)


			# White Rooks
			expect(@man.chessboard.grid[7][0].class.to_s).to eq("Rook")
			expect(@man.chessboard.grid[7][0].color).to eq(:white)

			expect(@man.chessboard.grid[7][7].class.to_s).to eq("Rook")
			expect(@man.chessboard.grid[7][7].color).to eq(:white)

			# White Knights
			expect(@man.chessboard.grid[7][1].class.to_s).to eq("Knight")
			expect(@man.chessboard.grid[7][1].color).to eq(:white)

			expect(@man.chessboard.grid[7][6].class.to_s).to eq("Knight")
			expect(@man.chessboard.grid[7][6].color).to eq(:white)

			# White King
			expect(@man.chessboard.grid[7][4].class.to_s).to eq("King")
			expect(@man.chessboard.grid[7][4].color).to eq(:white)

			# White Bishop
			expect(@man.chessboard.grid[7][2].class.to_s).to eq("Bishop")
			expect(@man.chessboard.grid[7][2].color).to eq(:white)

			expect(@man.chessboard.grid[7][5].class.to_s).to eq("Bishop")
			expect(@man.chessboard.grid[7][5].color).to eq(:white)

			# White Queen
			expect(@man.chessboard.grid[7][3].class.to_s).to eq("Queen")
			expect(@man.chessboard.grid[7][3].color).to eq(:white)

			# White Pawns
			0.upto(7) do |i|
				expect(@man.chessboard.grid[6][i].class.to_s).to eq("Pawn")
				expect(@man.chessboard.grid[6][i].color).to eq(:white)
			end


		end
	end

	describe "#movePossible?" do
		it "should allow king to make a valid move" do
			# stick a king in the middle of the board
			@man.chessboard.grid[3][3] = King.new(:white)
			expect(@man.movePossible?([3,3],[2,3])).to eq(true)
			expect(@man.movePossible?([3,3],[2,4])).to eq(true)
			expect(@man.movePossible?([3,3],[3,4])).to eq(true)
			expect(@man.movePossible?([3,3],[4,4])).to eq(true)
			expect(@man.movePossible?([3,3],[4,3])).to eq(true)
			expect(@man.movePossible?([3,3],[4,2])).to eq(true)
			expect(@man.movePossible?([3,3],[3,2])).to eq(true)
			expect(@man.movePossible?([3,3],[2,2])).to eq(true)
		end

		it "should allow king to move into opponent square (capture)" do
			# put a black pawn there instead
			@man.chessboard.grid[6][4] = Pawn.new(:black)			
			expect(@man.movePossible?([7,4], [6,4])).to eq(true)
		end

		it "should not allow king to move into his own teammate" do
			expect(@man.movePossible?([7,4], [6,4])).to eq(false)
		end

		it "should not allow king to move into checkmate by moving to empty square" do

		end

		it "should not allow king to move into checkmate by taking piece" do

		end

		it "should not allow king to move more than one space in a direction" do 
			# stick a king in the middle of the board
			@man.chessboard.grid[3][3] = King.new(:white)
			# try to move him a bit too far
			expect(@man.movePossible?([3,3],[1,3])).to eq(false)

		end
	end
end
