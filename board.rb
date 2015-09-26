require 'colorize'

class Board
	attr_accessor :grid
	attr_accessor :display

	def initialize
		@grid = Array.new(8) { Array.new(8) }		
	end

	def draw
		# Quick and dirty to see if things show up where they should, needs cleanup
		0.upto(7) do |row|
			print row+1
			0.upto(7) do |col|
				if grid[row][col].nil?
					if (row.even? and col.even?)
						print "  ".colorize(:background => :white)
					elsif (row.odd? and col.odd?)
						print "  ".colorize(:background => :white)
					else
						print "  ".colorize(:background => :yellow)
					end
				else
					piece = grid[row][col]
					if (row.even? and col.even?)											
						print "#{piece.unicode} ".colorize(:background => :white).colorize(:black)
					elsif (row.odd? and col.odd?)
						print "#{piece.unicode} ".colorize(:background => :white).colorize(:black)
					else
						print "#{piece.unicode} ".colorize(:background => :yellow).colorize(:black)
					end
				end
			end
			puts
		end
		puts " a b c d e f g h"
	end

	def draw2
		# copy the data into...
		#puts "#{display}"
		0.upto(7) do |r|
			0.upto(7) do |c|
				if !@grid[r][c].nil?
					#puts "#{@grid[r][c].unicode}".colorize(:green)
					#puts "#{@grid[0][0].color}".colorize(:green)
					@display[r][c][1][1] = @grid[r][c].unicode.encode('utf-8')
				end
			end
		end
		#chr = "\u2713".encode('utf-8')
		#puts chr.colorize(:yellow)

		0.upto(7) do |r|
			0.upto(7) do |c|
				print @display[r][c]
			end
		end

		puts "#{display}".colorize(:yellow)			
			
	end



end
