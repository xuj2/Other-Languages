require_relative "element"
require_relative "history"

class Player
	attr_reader :name, :history
	def initialize(name, history)
		@name = name
		@history = history
	end

	def play()
		fail "This method should be overridden"
	end
end

class StupidBot
	def initialize(name, history)
		@name = name
		@history = history
	end

	def play()
		@history.log_play("Rock")
		return Rock.new("Rock")
	end
end

class RandomBot
	def initialize(name, history)
		@name = name
		@history = history
	end

	def play()
		element = ["Rock", "Paper", "Scissors", "Lizard", "Spock"].sample
		@history.log_play(element)
		if element == "Rock"
			return Rock.new("Rock")
		elsif element == "Paper"
			return Paper.new("Paper")
		elsif element == "Scissors"
			return Scissors.new("Scissors")
		elsif element == "Lizard"
			return Lizard.new("Lizard")
		elsif element == "Spock"
			return Spock.new("Spock")
		end
	end
end

class IterativeBot
	def initialize(name, history)
		@name = name
		@history = history
	end

	def play()
		plays = @history.instance_variable_get(:@plays)
		if plays.size == 0
			element = "Rock"
			@history.log_play(element)
			return Rock.new("Rock")
		elsif plays[-1] == "Rock"
			element = "Paper"
			@history.log_play(element)
			return Paper.new("Paper")
		elsif plays[-1] == "Paper"
			element = "Scissors"
			@history.log_play(element)
			return Scissors.new("Scissors")
		elsif plays[-1] == "Scissors"
			element = "Lizard"
			@history.log_play(element)
			return Lizard.new("Lizard")
		elsif plays[-1] == "Lizard"
			element = "Spock"
			@history.log_play(element)
			return Spock.new("Spock")
		elsif plays[-1] == "Spock"
			element = "Rock"
			@history.log_play(element)
			return Rock.new("Rock")
		end
	end
end

class LastPlayBot
	def initialize(name, history)
		@name = name
		@history = history
	end

	def play()
		o_plays = @history.instance_variable_get(:@opponent_plays)
		if o_plays.size == 0
			@history.log_play("Rock")
			return Rock.new("Rock")
		end
		element = o_plays[-1]
		@history.log_play(element)
		if element == "Rock"
			return Rock.new("Rock")
		elsif element == "Paper"
			return Paper.new("Paper")
		elsif element == "Scissors"
			return Scissors.new("Scissors")
		elsif element == "Lizard"
			return Lizard.new("Lizard")
		elsif element == "Spock"
			return Spock.new("Spock")
		end
	end
end

class HumanPlayer
	def initialize(name, history)
		@name = name
		@history = history
	end

	def play()
		while true
			puts "(1) Rock "
			puts "(2) Paper "
			puts "(3) Scissors "
			puts "(4) Lizard "
			puts "(5) Spock "
			print "Enter your move: "
			n = gets.to_i
			if n == 1
				element = "Rock"
				@history.log_play(element)
				return Rock.new("Rock")
				break
			elsif n == 2
				element = "Paper"
				@history.log_play(element)
				return Paper.new("Paper")
				break
			elsif n == 3
				element = "Scissors"
				@history.log_play(element)
				return Scissors.new("Scissors")
				break
			elsif n == 4
				element = "Lizard"
				@history.log_play(element)
				return Lizard.new("Lizard")
				break
			elsif n == 5
				element = "Spock"
				@history.log_play(element)
				return Spock.new("Spock")
				break
			else
				puts "Invalid move - try again"
			end
		end
	end
end
