require_relative 'game'
class Set
    attr_accessor :game
    def initialize(player1, player2)
        @player1 = player1
        @player2 = player2
        @player1.games = 0
        @player2.games = 0
        @game = Game.new(player1, player2)
    end

    def score
        return "#{@player1.games}-#{@player2.games}"
    end

    def winner
        return @player1 if @player1.games > 5 && @player1.games > @player2.games + 1
        return @player2 if @player2.games > 5 && @player2.games > @player1.games + 1
    end

    def check_current_game
        @game.check_deuce
        winner = @game.winner
        if winner
            winner.win_game
            tie_break = (@player1.games == 6 && @player2.games == 6)
            @game = Game.new(@player1, @player2, tie_break)
        end
    end
end