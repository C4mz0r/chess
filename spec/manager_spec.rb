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
		context "when piece is a King" do
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

		context "when piece is a Pawn" do
			it "should allow Pawn to make a valid move" do
				# stick a king in the middle of the board
				@man.chessboard.grid[4][4] = Pawn.new(:white)
				expect(@man.movePossible?([4,4],[3,4])).to eq(true)				
			end

			it "should allow pawn to move diagonally into opponent square (capture)" do
				# put a black pawn there instead
				@man.chessboard.grid[5][4] = Pawn.new(:black)			
				expect(@man.movePossible?([6,5], [5,4])).to eq(true)
				expect(@man.movePossible?([6,3], [5,4])).to eq(true)
			end

			it "should not allow pawn to move into his own teammate" do
				@man.chessboard.grid[5][4] = Pawn.new(:white)			
				expect(@man.movePossible?([6,5], [5,4])).to eq(false)
			end

			it "should not allow a move that would put king in check" do
		
			end			

			it "should not allow moved pawn to move more than one space in a direction" do 
				# stick a pawn in the middle of the board
				moved_pawn = Pawn.new(:white)
				moved_pawn.has_moved = true
				@man.chessboard.grid[4][4] = moved_pawn

				# try to move him a bit too far
				expect(@man.movePossible?([4,4],[2,4])).to eq(false)

			end
		end

		context "when piece is a Rook" do
			it "should allow Rook to make a valid move" do
				# stick a rook in the middle of the board
				@man.chessboard.grid[4][4] = Rook.new(:white)
				expect(@man.movePossible?([4,4],[5,4])).to eq(true)
				expect(@man.movePossible?([4,4],[2,4])).to eq(true)				
				expect(@man.movePossible?([4,4],[4,5])).to eq(true)				
				expect(@man.movePossible?([4,4],[4,2])).to eq(true)				
			end

			it "should allow rook to capture" do
				# put a black pawn for it to capture
				@man.chessboard.grid[6][0] = Pawn.new(:black)			
				expect(@man.movePossible?([7,0], [6,0])).to eq(true)
			end

			it "should not allow pawn to move into his own teammate" do
				expect(@man.movePossible?([7,0], [6,0])).to eq(false)
			end

			it "should not allow a move that would put king in check" do
		
			end			

			it "should not allow rook to move in invalid direction" do 
				# stick a pawn in the middle of the board				
				@man.chessboard.grid[4][4] = Rook.new(:white)

				# try to move him in an invalid way
				expect(@man.movePossible?([4,4],[3,3])).to eq(false)

			end
		end

		context "when piece is a Knight" do
			it "should allow Knight to make a valid move" do
				# stick a Knight in the middle of the board
				@man.chessboard.grid[3][3] = Knight.new(:white)
				expect(@man.movePossible?([3,3],[4,5])).to eq(true)
				expect(@man.movePossible?([3,3],[2,5])).to eq(true)
			end

			it "should allow knight to capture opponent" do
				@man.current_turn = :black
				@man.chessboard.grid[5][5] = Knight.new(:black)			
				expect(@man.movePossible?([5,5], [6,7])).to eq(true)
			end

			it "should not allow knight to move into his own teammate" do
				@man.chessboard.grid[5][4] = Knight.new(:white)			
				expect(@man.movePossible?([5,4], [6,6])).to eq(false)
			end

			it "should not allow a move that would put king in check" do
		
			end			

			it "should not allow knight to move too far" do 
				
				@man.chessboard.grid[4][4] = Knight.new(:white)

				# try to move him a bit too far
				expect(@man.movePossible?([4,4],[2,2])).to eq(false)

			end
		end
	end

	describe "#pathIsClear" do
		context "when checking on a row" do
			it "should return false if something is in the way" do
				@man.chessboard.grid[3][0] = Rook.new(:white)
				@man.chessboard.grid[3][6] = Rook.new(:white)
				expect(@man.pathIsClear?([3,0],[3,7])).to eq(false)
			end

			it "should return true if nothing is in the way" do
				@man.chessboard.grid[3][0] = Rook.new(:white)
				expect(@man.pathIsClear?([3,0],[3,7])).to eq(true)
			end	

			it "should not check the endpoint" do
				# even though there is something at [3,6], the path should return true
				# as we do not include the endpoint in the pathIsClear logic
				@man.chessboard.grid[3][0] = Rook.new(:white)
				@man.chessboard.grid[3][6] = Rook.new(:white)
				expect(@man.pathIsClear?([3,0],[3,6])).to eq(true)
			end
	
			it "should function if the path is opposite direction" do
				@man.chessboard.grid[3][0] = Rook.new(:white)
				@man.chessboard.grid[3][6] = Rook.new(:white)
				expect(@man.pathIsClear?([3,6],[3,0])).to eq(true)
			end
		end

		context "when checking on a column" do
			it "should return false if something is in the way" do
				@man.chessboard.grid[2][0] = Rook.new(:white)
				@man.chessboard.grid[4][0] = Rook.new(:white)
				expect(@man.pathIsClear?([2,0],[5,0])).to eq(false)
			end

			it "should return true if nothing is in the way" do
				@man.chessboard.grid[2][0] = Rook.new(:white)
				expect(@man.pathIsClear?([2,0],[5,0])).to eq(true)
			end	

			it "should not check the endpoint" do
				# even though there is something at [5,0], the path should return true
				# as we do not include the endpoint in the pathIsClear logic
				@man.chessboard.grid[2][0] = Rook.new(:white)
				@man.chessboard.grid[5][0] = Rook.new(:white)
				expect(@man.pathIsClear?([2,0],[5,0])).to eq(true)
			end	
		end

		context "when checking a diagonal path" do
			
			it "should return true if nothing is in the way - diagonal 1" do
				@man.chessboard.grid[2][0] = Rook.new(:white)
				@man.chessboard.grid[4][2] = Rook.new(:white)
				expect(@man.pathIsClear?([2,0],[4,2])).to eq(true)
			end

			it "should return false if something is in the way - diagonal 1" do
				@man.chessboard.grid[2][0] = Rook.new(:white)
				@man.chessboard.grid[3][1] = Rook.new(:white)
				@man.chessboard.grid[4][2] = Rook.new(:white)
				expect(@man.pathIsClear?([2,0],[4,2])).to eq(false)
			end

			it "should return true if nothing is in the way - diagonal 1 other direction" do
				@man.chessboard.grid[2][0] = Rook.new(:white)
				@man.chessboard.grid[4][2] = Rook.new(:white)
				expect(@man.pathIsClear?([4,2],[2,0])).to eq(true)
			end

			it "should return false if something is in the way - diagonal 1 other direction" do
				@man.chessboard.grid[2][0] = Rook.new(:white)
				@man.chessboard.grid[3][1] = Rook.new(:white)
				@man.chessboard.grid[4][2] = Rook.new(:white)
				expect(@man.pathIsClear?([4,2],[2,0])).to eq(false)
			end

			it "should return true if nothing is in the way - diagonal 2" do
				@man.chessboard.grid[2][2] = Rook.new(:white)
				@man.chessboard.grid[4][0] = Rook.new(:white)
				expect(@man.pathIsClear?([2,2],[4,0])).to eq(true)
			end

			it "should return false if something is in the way - diagonal 2" do
				@man.chessboard.grid[2][2] = Rook.new(:white)
				@man.chessboard.grid[3][1] = Rook.new(:white)
				@man.chessboard.grid[4][0] = Rook.new(:white)
				expect(@man.pathIsClear?([2,2],[4,0])).to eq(false)
			end

			it "should return true if nothing is in the way - diagonal 2 other direction" do
				@man.chessboard.grid[2][2] = Rook.new(:white)
				@man.chessboard.grid[4][0] = Rook.new(:white)
				expect(@man.pathIsClear?([4,0],[2,2])).to eq(true)
			end
	
			it "should return false if something is in the way - diagonal 2 other direction" do
				@man.chessboard.grid[2][2] = Rook.new(:white)
				@man.chessboard.grid[3][1] = Rook.new(:white)
				@man.chessboard.grid[4][0] = Rook.new(:white)
				expect(@man.pathIsClear?([4,0],[2,2])).to eq(false)
			end

		end
	end

	describe "#isCheck?" do
		it "should return false if king is not in check" do
			@man.chessboard.grid[6][4] = nil
			expect(@man.isCheck?(:white)).to eq(false)

			@man.chessboard.grid[6][4] = Pawn.new(:black)
			expect(@man.isCheck?(:white)).to eq(false)
		end

		it "should return true if king is in check" do
			@man.chessboard.grid[6][3] = Pawn.new(:black)
			#@man.current_turn = :black
			expect(@man.isCheck?(:white)).to eq(true)
		end
	end
end
