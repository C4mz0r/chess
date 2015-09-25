class Manager
	attr_accessor :chessboard

	def initialize
		@chessboard = Board.new
		#puts "have #{@chessboard.inspect}"
		setupPieces
		#puts "have #{@chessboard.inspect}"
	end

	def movePossible?(current, desired)
		piece = @chessboard.grid[current[0]][current[1]]
		if piece.nil?
			puts "There is no piece at location #{current}"
			return false
		end

		case piece.class.to_s
		when "King"
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			if piece.moves.include?desired_shift
				puts "The move is in the move list, but need to check line of sight"
				capture_piece = @chessboard.grid[desired[0]][desired[1]]
				if ( capture_piece.nil? )
					puts "King can move to empty space"
					return true
				elsif ( capture_piece.color == piece.color )
					puts "Can't take your own piece"
					return false
				else
					puts "Can take opponent piece"
					return true
				end
			else
				puts "The move is not in the move list"
				return false
			end
		when "Knight"
			puts "Blaargh"

		else 
			puts "Piece #{piece} is not a valid chess piece"
		end

	end

	private
		def setupPieces
			@chessboard.grid[0][0] = Rook.new(:black)
			@chessboard.grid[0][1] = Knight.new(:black)
			@chessboard.grid[0][2] = Bishop.new(:black)
			@chessboard.grid[0][3] = Queen.new(:black)
			@chessboard.grid[0][4] = King.new(:black)
			@chessboard.grid[0][5] = Bishop.new(:black)
			@chessboard.grid[0][6] = Knight.new(:black)
			@chessboard.grid[0][7] = Rook.new(:black)
			0.upto(7) { |i| @chessboard.grid[1][i] = Pawn.new(:black) }

			@chessboard.grid[7][0] = Rook.new(:white)
			@chessboard.grid[7][1] = Knight.new(:white)
			@chessboard.grid[7][2] = Bishop.new(:white)
			@chessboard.grid[7][3] = Queen.new(:white)
			@chessboard.grid[7][4] = King.new(:white)
			@chessboard.grid[7][5] = Bishop.new(:white)
			@chessboard.grid[7][6] = Knight.new(:white)
			@chessboard.grid[7][7] = Rook.new(:white)
			0.upto(7) { |i| @chessboard.grid[6][i] = Pawn.new(:white) }
		end

end
