require_relative 'manager'

class Game

	def initialize()
		@manager = Manager.new	
	end

	def gameLoop()		
		loop do
			@manager.chessboard.draw
			puts "[#{@manager.current_turn}]  Enter move (fromRow fromCol toRow toCol):"
			a,b,c,d = gets.chomp.split
			puts "Got abcd = #{a}, #{b}, #{c}, #{d}"
			@manager.movePiece([a.to_i,b.to_i],[c.to_i,d.to_i])
		end
	end

end

game = Game.new
game.gameLoop
