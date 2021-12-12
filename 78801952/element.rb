class Element
	attr_accessor :name
	def initialize(name)
		@name = name
	end

	def compare_to(obj)
		fail "This method should be overriden"	
	end
end

class Rock
	def initialize(name)
		@name = name
	end
	def compare_to(obj)
		if obj.getName == "Rock"
			return "Rock equals Rock", "Tie"
		elsif obj.getName == "Paper"
			return "Paper covers Rock", "Lose"
		elsif obj.getName == "Scissors"
			return "Rock crushes Scissors", "Win"
		elsif obj.getName == "Lizard"
			return "Rock crushes Lizard", "Win"
		else
			return "Spock vaporizes Rock", "Lose"
		end
	end
	def getName
		@name
	end
end

class Paper
	def initialize(name)
		@name = name
	end
	def compare_to(obj)
		if obj.getName == "Rock"
			return "Paper covers Rock", "Win"
		elsif obj.getName == "Paper"
			return "Paper equals Paper", "Tie"
		elsif obj.getName == "Scissors"
			return "Scissors cut Paper", "Lose"
		elsif obj.getName == "Lizard"
			return "Lizard eats Paper", "Lose"
		else
			return "Paper disproves Spock", "Win"
		end
	end
	def getName
		@name
	end
end

class Scissors
	def initialize(name)
		@name = name
	end
	def compare_to(obj)
		if obj.getName == "Rock"
			return "Rock crushes Scissors", "Lose"
		elsif obj.getName == "Paper"
			return "Scissors cut Paper", "Win"
		elsif obj.getName == "Scissors"
			return "Scissors equals Scissors", "Tie"
		elsif obj.getName == "Lizard"
			return "Scissors decapitate Lizard", "Win"
		else
			return "Spock smashes Scissors", "Lose"
		end
	end
	def getName
		@name
	end
end

class Lizard
	def initialize(name)
		@name = name
	end
	def compare_to(obj)
		if obj.getName == "Rock"
			return "Rock crushes Lizard", "Lose"
		elsif obj.getName == "Paper"
			return "Lizard eats Paper", "Win"
		elsif obj.getName == "Scissors"
			return "Scissors decapitate Lizard", "Lose"
		elsif obj.getName == "Lizard"
			return "Lizard equals Lizard", "Tie"
		else
			return "Lizard poisons Spock", "Win"
		end
	end
	def getName
		@name
	end
end

class Spock
	def initialize(name)
		@name = name
	end
	def compare_to(obj)
		if obj.getName == "Rock"
			return "Spock vaporizes Rock", "Win"
		elsif obj.getName == "Paper"
			return "Paper disproves Spock", "Lose"
		elsif obj.getName == "Scissors"
			return "Spock smashes Scissors", "Win"
		elsif obj.getName == "Lizard"
			return "Lizard poisons Spock", "Lose"
		else
			return "Spock equals Spock", "Tie"
		end
	end
	def getName
		@name
	end
end

