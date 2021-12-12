require_relative "element"   # uncomment to load element.rb
require_relative "player"    # uncomment to load player.rb 
require_relative "history"   # uncomment to load history.rb

def game(rounds)
	puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
	puts "\n"
	puts "Please choose two players:"
	puts "(1) StupidBot "
	puts "(2) RandomBot "
	puts "(3) IterativeBot "
	puts "(4) LastPlayBot "
	puts "(5) Human "
	p1 = 0
	p2 = 0
	player_names = ["StupidBot", "RandomBot", "IterativeBot", "LastPlayBot", "Human"]
	while true
		print "Select player 1:"
		p1 = gets.to_i
		print "Select player 2:"
		p2 = gets.to_i
		if p1 <= 5 and p1 >= 1
			if p2 <= 5 and p2 >= 1
				break
			else
				puts "Invalid choice(s) - start over "
			end
		else
			puts "Invalid choice(s) - start over "
		end
	end
	puts "%s vs. %s" % [player_names[p1 - 1], player_names[p2 - 1]]
	print "\n"

	if p1 == 1
		player1 = StupidBot.new("StupidBot", History.new)
	elsif p1 == 2
		player1 = RandomBot.new("RandomBot", History.new)
	elsif p1 == 3
		player1 = IterativeBot.new("IterativeBot", History.new)
	elsif p1 == 4
		player1 = LastPlayBot.new("LastPlayBot", History.new)
	elsif p1 == 5
		player1 = HumanPlayer.new("HumanPlayer", History.new)
	end
	if p2 == 1
		player2 = StupidBot.new("StupidBot", History.new)
	elsif p2 == 2
		player2 = RandomBot.new("RandomBot", History.new)
	elsif p2 == 3
		player2 = IterativeBot.new("IterativeBot", History.new)
	elsif p2 == 4
		player2 = LastPlayBot.new("LastPlayBot", History.new)
	elsif p2 == 5
		player2 = HumanPlayer.new("HumanPlayer", History.new)
	end
	
	rounds.times do |i|
		move1 = 0
		move2 = 0
		round_number = i + 1
		puts "Round %d:" % round_number
		
		player1_move = player1.play()
		player2_move = player2.play()

		player1.instance_variable_get(:@history).log_opponent_play(player2_move.getName)
		player2.instance_variable_get(:@history).log_opponent_play(player1_move.getName)

		puts "Player 1 chose %s" % player1_move.getName
		puts "Player 2 chose %s" % player2_move.getName
		line, result = player1_move.compare_to(player2_move)
		puts line
		if result == "Win"
			puts "Player 1 won the round "
			player1.instance_variable_get(:@history).add_score
		elsif result == "Tie"
			puts "Round was a tie "
		elsif result == "Lose"
			puts "Player 2 won the round "
			player2.instance_variable_get(:@history).add_score
		end
		puts "\n"
	end
	p1_score = player1.instance_variable_get(:@history).instance_variable_get(:@score)
	p2_score = player2.instance_variable_get(:@history).instance_variable_get(:@score)
	puts "Final score is %d to %d" % [p1_score, p2_score]
	if p1_score > p2_score
		puts "Player 1 wins "
	elsif p1_score == p2_score
		puts "Game was a draw "
	else
		puts "Player 2 wins "
	end
end


# Main Program (should be last)
n_rounds = 5
# call to kick off the game
game(n_rounds)
