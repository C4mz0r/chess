require_relative 'manager'

class Game

	def initialize()
		@manager = Manager.new	
	end

	def gameLoop()		
		loop do
			@manager.chessboard.draw

			begin
				puts "[#{@manager.current_turn}]  Enter move (e.g. a 7 a 5 to move from a7 to a5):"
				from_letter,from_number,to_letter,to_number = gets.chomp.split
					
				# convert letters to 0-based indices used by the board
				from_column = from_letter.ord - 'a'.ord
				to_column = to_letter.ord - 'a'.ord
			rescue
				retry
			end
			
			@manager.movePiece([from_number.to_i-1,from_column],[to_number.to_i-1,to_column])
		end
	end

end

game = Game.new
game.gameLoop
