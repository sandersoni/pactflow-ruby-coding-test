require 'byebug'
require 'test/unit'
require_relative 'player'
require_relative 'game'
require_relative 'set'

class Match
    attr_accessor :set

    def initialize(player1_name, player2_name)
        @player1 = Player.new(player1_name)
        @player2 = Player.new(player2_name)
        @set = Set.new(@player1, @player2)
    end

    def point_won_by(player_name)
        winning_player = nil
        if @player1.name == player_name
            winning_player = @player1
        elsif @player2.name == player_name
            winning_player = @player2
        else
            raise ArgumentError, "Player name '#{player_name}' does not match any players in this match."
        end

        winning_player.win_point

        @set.check_current_game
        check_current_set
    end

    def check_current_set
        winner = @set.winner
        if winner
            winner.win_set
            puts "#{winner.name} has won the set!" unless ENV['RUBY_ENV'] == 'test'

            # If we were doing more than just one set, then we'd create another and keep going
            # @set = Set.new(@player1, @player2)
        end
    end

    def score
        "#{@set.score}, #{@set.game.score}"
    end

    alias_method :pointWonBy, :point_won_by # For if you want to use camel-casing like the instructions specify
end