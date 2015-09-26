require 'colorize'

class Board
	attr_accessor :grid

	def initialize
		@grid = Array.new(8) { Array.new(8) }
	end

	def draw
		# Quick and dirty to see if things show up where they should, needs cleanup
		0.upto(7) do |row|
			0.upto(7) do |col|
				if grid[row][col].nil?
					if (row.even? and col.even?)
						print " ".colorize(:background => :yellow)
					elsif (row.odd? and col.odd?)
						print " ".colorize(:background => :yellow)
					else
						print " "
					end
				else
					piece = grid[row][col].class.to_s[0].colorize(grid[row][col].color)
					if (row.even? and col.even?)
						print piece.colorize(:background => :yellow)
					elsif (row.odd? and col.odd?)
						print piece.colorize(:background => :yellow)
					else
						print piece
					end
				end
			end
			puts
		end
	end

end
