class Piece
	attr_accessor :has_moved
	attr_accessor :color
	attr_accessor :moves
	attr_accessor :first_moves
	attr_accessor :attack_moves

	def initialize(color, moves, attack_moves = moves)
		@color = color
		@has_moved = false

		if (@color == :white)				
			@moves = moves
			@attack_moves = attack_moves
		elsif (@color == :black)
			@moves = Piece.reverseDirection(moves)
			@attack_moves = Piece.reverseDirection(attack_moves)
		end
	end
=begin
	def tryMove( move )
		if moves.include?move
			puts "Trying to move with #{move}"
		else
			puts "Invalid move attempted for piece"
			return false
		end
	end
=end
	def Piece.reverseDirection( possible_moves )
		possible_moves.map{ |row,col| [-row,col] }
	end
end

class Pawn < Piece
	def initialize(color)
		moves = [ [1,0], [2,0] ]
		attack_moves = [ [1,-1], [1,1] ]
		super(color, moves, attack_moves)
	end
end

class King < Piece
	def initialize(color)
		moves = [ [1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1] ]
		super(color, moves)
	end

end

class Rook < Piece
	def initialize(color)
		moves = [ 	[1,0], [0,1], [-1,0], [0,-1],
				[2,0], [0,2], [-2,0], [0,-2],
				[3,0], [0,3], [-3,0], [0,-3],
				[4,0], [0,4], [-4,0], [0,-4],
				[5,0], [0,5], [-5,0], [0,-5],
				[6,0], [0,6], [-6,0], [0,-6],
				[7,0], [0,7], [-7,0], [0,-7]				
		 	]
		super(color, moves)
	end
end

class Knight < Piece
	def initialize(color)
		moves = [ 	[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1] 	]
		super(color, moves)
	end
end

class Bishop < Piece
	def initialize(color)
		moves = [ 	[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7],
				[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7],
				[1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7],
				[-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7]
		 	]
		super(color, moves)
	end
end

class Queen < Piece
	def initialize(color)
		moves = [ 	[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7],
				[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7],
				[1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7],
				[-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7],
				[1,0], [0,1], [-1,0], [0,-1],
				[2,0], [0,2], [-2,0], [0,-2],
				[3,0], [0,3], [-3,0], [0,-3],
				[4,0], [0,4], [-4,0], [0,-4],
				[5,0], [0,5], [-5,0], [0,-5],
				[6,0], [0,6], [-6,0], [0,-6],
				[7,0], [0,7], [-7,0], [0,-7],
				[8,0], [0,8], [-8,0], [0,-8]
		 	]
		super(color, moves)
	end
end
