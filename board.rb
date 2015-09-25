require 'colorize'

class Board
	attr_accessor :grid

	def initialize
		@grid = Array.new(8) { Array.new(8) }
	end

	def draw
		puts "#{grid}.inspect"	
	end

end
