require_relative 'board'
require_relative 'piece'

class Manager
	attr_accessor :chessboard
	attr_accessor :current_turn
	attr_accessor :white_king_status
	attr_accessor :black_king_status

	def initialize
		@chessboard = Board.new
		@current_turn = :white
		setupPieces
	end

	# check if path is clear b/w current and desired spot (not including desired spot)
	# not needed for Knight, or pieces that only move one spot
	def pathIsClear?(current,desired)
		piece_in_way = false

		# same row		
		if ( current[0] == desired[0] )
			start = [ current[1], desired[1] ].min
			finish = [ current[1], desired[1] ].max
			(start+1).upto(finish-1) do |i|
				puts "looking at #{i}"
				if !@chessboard.grid[current[0]][i].nil?
					piece_in_way = true
					puts "There is a piece in the way @#{current[0]}, #{i}"
					#puts "FOund:  #{@chessboard.grid.[current[0]][i]}"
					break
				end	
			end
		

		# same col
		elsif ( current[1] == desired[1] ) 
			start = [ current[0], desired[0] ].min
			finish = [ current[0], desired[0] ].max
			(start+1).upto(finish-1) do |i|
				if !@chessboard.grid[i][current[1] ].nil?
					piece_in_way = true
					break
				end	
			end
		

		# diagonal
		elsif ( current[1] != desired[1] and current[0] != desired[0] ) 
			
			if  ( current[0] > desired[0] and current[1] < desired[1] )
				puts "In diagonal branch A".colorize(:yellow)
				# path is a diagonal like this:  / (current is bottom left pt)
				1.upto(current[0]-desired[0]-1) do |i|
					#puts "Checking coord #{current[0]-i}, #{current[1]+i}"
					#puts "fond:  #{@chessboard.grid[current[0]-i][ current[1]+i ]}"
					if !@chessboard.grid[ current[0]-i][ current[1]+i ].nil?
						piece_in_way = true
						break
					end
				end
				puts "leaving diagonal branch A have, #{piece_in_way}".colorize(:yellow)			

			elsif ( current[0] < desired[0] and current[1] > desired[1] ) 
				# path is a diagonal like this:  / (current is top rt pt)
				puts "In diagonal branch B".colorize(:yellow)
				1.downto(desired[0]-current[0]-1) do |i|
					#puts "Checking coord #{current[1]+i}, #{current[0]-i}"
					#puts "fond:  #{@chessboard.grid[current[1]+i][ current[0]-i ]}"
					if !@chessboard.grid[ current[1]+i][ current[0]-i ].nil?
						piece_in_way = true
						break
					end
				end
				puts "leaving diagonal branch B have, #{piece_in_way}".colorize(:yellow)
								
			elsif ( current[0] < desired[0] and current[1] < desired[1] )
				puts "In diagonal branch C ".colorize(:yellow)
				# path is on a diagonal like this: \ (current is top left)
				1.upto(desired[0]-current[0]-1) do |i|
					#puts "Checking coord #{current[0]+i}, #{current[1]+i}"
					#puts "fond:  #{@chessboard.grid[current[0]+i][ current[1]+i ]}"
					if !@chessboard.grid[ current[0]+i][ current[1]+i ].nil?
						piece_in_way = true
						break
					end
				end
				puts "leaving diagonal branch C have, #{piece_in_way}".colorize(:yellow)		
			elsif ( current[0] > desired[0] and current[1] > desired[1] )
				puts "In diagonal branch D with #{piece_in_way}".colorize(:yellow)
				#piece_in_way = true
				# path is on a diagonal like this: \
				1.downto(current[0]-desired[0]-1) do |i|
					#puts "Checking coord #{current[0]-i}, #{current[1]-i}"
					#puts "fond:  #{@chessboard.grid[current[0]-i][ current[1]-i ]}"
					if !@chessboard.grid[ current[0]-i][ current[1]-i ].nil?
						piece_in_way = true
						break
					end
				end
				puts "leaving diagonal branch D have, #{piece_in_way}".colorize(:yellow)			
			end
			

		
		end
		
		!piece_in_way
	end

	# check if the king of specified color is in check
	def isCheck?(color)
		# for each opponent piece on the board, if the piece could movePossible? to the king then
		# it would be considered check
		
		# get a handle to the king, get his position.
		# ok, now I can see how crappy it is to have to search the board for pieces...
		check = false		
		
		the_king = nil
		king_row = nil
		king_col = nil
		0.upto(7) do |r|
			0.upto(7) do |c|
				if @chessboard.grid[r][c].class.to_s == "King" and @chessboard.grid[r][c].color == color then
					the_king = @chessboard.grid[r][c]
					king_row = r
					king_col = c
					break
				end
			end
		end
		
		0.upto(7) do |r|
			0.upto(7) do |c|
				if !@chessboard.grid[r][c].nil? and @chessboard.grid[r][c].color != color then
					desired = [king_row, king_col]
					current = [r,c]
					oppositeColor = (color == :white)? :black : :white
					if movePossible?(current, desired, oppositeColor)
						check = true
						break
					end
				end
			end
		end
		
		return check
	end	


	def movePiece(current, desired)
		if movePossible?(current, desired) then
			captured_piece = @chessboard.grid[desired[0]][desired[1]]
			@chessboard.grid[desired[0]][desired[1]] = @chessboard.grid[current[0]][current[1]]
			@chessboard.grid[current[0]][current[1]] = nil
			
			# ensure that haven't put self into check...This should really be part of movePossible checking..
			if ( isCheck?(@current_turn) )
				puts "Warning:  That would put you in check!  Reverting..."
				# turn things back
				@chessboard.grid[current[0]][current[1]] = @chessboard.grid[desired[0]][desired[1]]
				@chessboard.grid[desired[0]][desired[1]] = captured_piece				
			else			
				@current_turn = (@current_turn == :white) ? :black : :white
			end
		else
			puts "The move is not possible! #{@current_turn}, you will need to try again."
		end
	end

	# Through normaly play, would call current/desired to see if a user can move to new spot based on his turn
	# But since we needed to do some theoretical checks to see if the opponent is in check mate, we have provided
	# playerColor to allow us to do the checks even if it is the other guys turn.
	# That is, suppose it is white's turn:  If I call movePossible? for any black pieces, it will show error saying
	# that you cannot move opponent pieces.  But suppose I just want to check if the move would be possible in theory, if it wa
	# black's turn:  Then we can call movePossible specifying the playerColor as black.
	# Seems hacky, but I wanted to be able to reuse this function to help tell if King is in check.
	def movePossible?(current, desired, playerColor = @current_turn)
		piece = @chessboard.grid[current[0]][current[1]]
		if piece.nil?
			puts "There is no piece at location #{current}"
			return false
		end

		if piece.color != playerColor
			puts "You can not move your opponent's pieces!"
			return false
		end

		case piece.class.to_s
		when "King"
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			if piece.moves.include?desired_shift
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
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			piece_at_destination = @chessboard.grid[desired[0]][desired[1]]
			
			if piece.moves.include?desired_shift								
				if ( piece_at_destination.nil? )
					puts "Knight can move to empty space"
					return true
				elsif ( piece_at_destination.color == piece.color )
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
		when "Rook"
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			piece_at_destination = @chessboard.grid[desired[0]][desired[1]]
			
			if piece.moves.include?desired_shift
				# need to check LOS	
				if pathIsClear?(current,desired)							
					if ( piece_at_destination.nil? )
						puts "Rook can move to empty space"
						return true
					elsif ( piece_at_destination.color == piece.color )
						puts "Can't take your own piece"
						return false
					else
						puts "Can take opponent piece"
						return true
					end
				else
					puts "The path is not clear"
					return false
				end
			else
				puts "The move is not in the move list"
				return false
			end
		when "Queen"
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			piece_at_destination = @chessboard.grid[desired[0]][desired[1]]
			
			if piece.moves.include?desired_shift
				# need to check LOS	
				if pathIsClear?(current,desired)							
					if ( piece_at_destination.nil? )
						puts "Queen can move to empty space"
						return true
					elsif ( piece_at_destination.color == piece.color )
						puts "Can't take your own piece"
						return false
					else
						puts "Can take opponent piece"
						return true
					end
				else
					puts "The path is not clear"
					return false
				end
			else
				puts "The move is not in the move list"
				return false
			end
		when "Bishop"
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			piece_at_destination = @chessboard.grid[desired[0]][desired[1]]
			
			if piece.moves.include?desired_shift
				# need to check LOS	
				if pathIsClear?(current,desired)							
					if ( piece_at_destination.nil? )
						puts "Queen can move to empty space"
						return true
					elsif ( piece_at_destination.color == piece.color )
						puts "Can't take your own piece"
						return false
					else
						puts "Can take opponent piece"
						return true
					end
				else
					puts "The path is not clear"
					return false
				end
			else
				puts "The move is not in the move list"
				return false
			end
		when "Pawn"
			# ensure the move is in the list of possible moves
			desired_shift = [ desired[0]-current[0], desired[1]-current[1] ]
			piece_at_destination = @chessboard.grid[desired[0]][desired[1]]
			
			# if pawn has moved, ensure that it can no longer move 2 spaces
			# this seems like wrong spot for this... ;)
			if piece.has_moved
				piece.moves.delete([2,0])
				piece.moves.delete([-2,0])
			end

			#puts "Found #{piece_at_destination}"
			#puts "Found #{piece.attack_moves} .. #{desired_shift}"
			if piece.moves.include?desired_shift			
				if ( piece_at_destination.nil? )
					puts "Pawn can move to empty space"
					return true
				else
					puts "Pawn cannot move into spot that has another piece"
					return false
				end
			elsif piece.attack_moves.include?desired_shift
				if ( piece_at_destination.color != piece.color )
					puts "Pawn can capture the opponent piece"
					return true
				else
					puts "Pawn cannot capture own teammate"
					return false
				end
			else
				puts "The move is not in the move list"
				return false
			end
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
