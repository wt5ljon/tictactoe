class Board
	def initialize
		@board = { "TL"=>" ", "TM"=>" ", "TR"=>" ",
			         "ML"=>" ", "MM"=>" ", "MR"=>" ",
							 "BL"=>" ", "BM"=>" ", "BR"=>" " }
	end

	def set_board(position, symbol)
		@board[position] = symbol
	end

	def get_board
		@board
	end

	def display_board(start=false)
		if start
			puts ""
			puts "   TL | TM | TR "
			puts "  ----+----+----"
			puts "   ML | MM | MR "
			puts "  ----+----+----"
			puts "   BL | BM | BR "
			puts ""
		else
			puts ""
			puts "   #{@board['TL']} | #{@board['TM']} | #{@board['TR']} "
			puts "  ---+---+---"
			puts "   #{@board['ML']} | #{@board['MM']} | #{@board['MR']} "
			puts "  ---+---+---"
			puts "   #{@board['BL']} | #{@board['BM']} | #{@board['BR']} "
			puts ""
		end

		def draw?
			entries = @board.select { |k,v| v != " " }
			return entries.length == 9
		end
	end

	def win?(s)
		if @board["TL"] == s && @board["TM"] == s &&  @board["TR"] == s
			return true
		elsif @board["ML"] == s && @board["MM"] == s && @board["MR"] == s
			return true
		elsif @board["BL"] == s && @board["BM"] == s && @board["BR"] == s
			return true
		elsif @board["TL"] == s && @board["ML"] == s && @board["BL"] == s
			return true
		elsif @board["TM"] == s && @board["MM"] == s && @board["BM"] == s
			return true
		elsif @board["TR"] == s && @board["MR"] == s && @board["BR"] == s
			return true
		elsif @board["TL"] == s && @board["MM"] == s && @board["BR"] == s
			return true
		elsif @board["TR"] == s && @board["MM"] == s && @board["BL"] == s
			return true
		else
			return false
		end
	end

	def valid_position?(position)
		return @board.keys.include?(position)
	end

	def occupied?(position)
		return @board[position] == "X" || @board[position] == "O"
	end
end

class Player
	attr_reader :name

	def initialize(name)
		@name = name
	end
end

class Game
	def initialize(name1, name2)
		@player1 = Player.new(name1)
		@player2 = Player.new(name2)
		@board = Board.new
	end

	def play 
		current_player = @player1
		current_symbol = "X"
		win = false
		@board.display_board(true)
		while !win
			position = get_user_input(current_player)
			@board.set_board(position, current_symbol)
			@board.display_board
			win = @board.win?(current_symbol)
			if win
				puts " *** #{current_player.name} Wins!! - Game Over! ***"
				puts ""
			else
				if @board.draw?
					puts " *** Game Is A Draw!! - Game Over! ***"
					puts ""
					break
				end
				if current_player == @player1
					current_player = @player2
					current_symbol = "O"
				else
					current_player = @player1
					current_symbol = "X"
				end
			end
		end
	end

	private
	def get_user_input(current_player)
		while true
			print "  #{current_player.name}'s Turn: "
			position = gets.chomp.upcase
			if not @board.valid_position?(position)
				puts ""
				puts "  Valid Entries: "
				puts "  TL (Top Left)   \tTM (Top Middle)   \tTR (Top Right)"
				puts "  ML (Middle Left)\tMM (Middle Middle)\tMR (Middle Right)"
				puts "  BL (Bottom Left)\tBM (Bottom Middle)\tBR (Bottom Right)"
				puts ""
			else
				if @board.occupied?(position)
					puts ""
					puts "  Position is occupied - Try Again "
					puts ""
				else
					break
				end
			end	
		end
		return position
	end
end

game = Game.new("Tom", "Harry")
game.play

