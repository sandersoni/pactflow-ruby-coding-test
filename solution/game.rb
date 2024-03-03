class Game
    attr_accessor :tie_break
    def initialize(player1, player2, tie_break=false)
        raise ArgumentError, "Players must have different names" if player1.name == player2.name
        @player1 = player1
        @player2 = player2
        @player1.points = 0
        @player2.points = 0
        @tie_break = tie_break
    end

    def special_score_map
        {
            [0,0] => "0-0", # I guess "love all" isn't conventional?
            [4,3] => "Advantage #{@player1.name}",
            [3,4] => "Advantage #{@player2.name}",
            [3,3] => "Deuce"
        } [ [@player1.points, @player2.points] ]
    end

    def score
        return "#{@player1.points}-#{@player2.points}" if tie_break
        return special_score_map || "#{@player1.points_call}-#{@player2.points_call}"
    end

    # If a player breaks the advantage back to deuce
    def check_deuce
        return if tie_break
        if @player1.points == 4 && @player2.points == 4
            @player1.points = 3
            @player2.points = 3
        end
    end

    def winner
        if tie_break
            return @player1 if @player1.points > 6 && @player1.points > @player2.points + 1
            return @player2 if @player2.points > 6 && @player2.points > @player1.points + 1
        else
            return @player1 if @player1.points > 3 && @player1.points > @player2.points + 1
            return @player2 if @player2.points > 3 && @player2.points > @player1.points + 1
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "This class is not meant to be run directly."
    puts "if you want to run a match of tennis, run match.rb."
  end