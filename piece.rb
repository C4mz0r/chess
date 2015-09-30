class Piece
	attr_accessor :has_moved
	attr_accessor :color
	attr_accessor :moves
	attr_accessor :first_moves
	attr_accessor :attack_moves
	attr_accessor :unicode

	def initialize(color, moves, attack_moves = moves, unicode = nil)
		@color = color
		@has_moved = false
		@unicode = unicode
		if (@color == :black)				
			@moves = moves
			@attack_moves = attack_moves
		elsif (@color == :white)
			@moves = Piece.reverseDirection(moves)
			@attack_moves = Piece.reverseDirection(attack_moves)
		end
	end

	def Piece.reverseDirection( possible_moves )
		possible_moves.map{ |row,col| [-row,col] }
	end
end

class Pawn < Piece
	def initialize(color)
		moves = [ [1,0], [2,0] ]
		attack_moves = [ [1,-1], [1,1] ]
		unicode = (color == :white) ? "\u2659" : "\u265F"
		super(color, moves, attack_moves, unicode)
	end
end

class King < Piece
	def initialize(color)
		moves = [ [1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1] ]
		unicode = (color == :white) ? "\u2654" : "\u265A"
		super(color, moves, moves, unicode)
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
		unicode = (color == :white) ? "\u2656" : "\u265C"
		super(color, moves, moves, unicode)
	end
end

class Knight < Piece
	def initialize(color)
		moves = [ 	[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1] 	]
		unicode = (color == :white) ? "\u2658" : "\u265E"
		super(color, moves, moves, unicode)
	end
end

class Bishop < Piece
	def initialize(color)
		moves = [ 	[1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7],
				[-1,1], [-2,2], [-3,3], [-4,4], [-5,5], [-6,6], [-7,7],
				[1,-1], [2,-2], [3,-3], [4,-4], [5,-5], [6,-6], [7,-7],
				[-1,-1], [-2,-2], [-3,-3], [-4,-4], [-5,-5], [-6,-6], [-7,-7]
		 	]
		unicode = (color == :white) ? "\u2657" : "\u265D"
		super(color, moves, moves, unicode)
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
		unicode = (color == :white) ? "\u2655" : "\u265B"
		super(color, moves, moves, unicode)
	end
end
