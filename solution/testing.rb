require 'byebug'
require 'test/unit'
require_relative 'player'
require_relative 'game'
require_relative 'set'
require_relative 'match'

ENV['RUBY_ENV'] = 'test'

class PlayerTest < Test::Unit::TestCase
    def test_player_points
        player1 = Player.new('player1')
        assert_equal 'player1', player1.name
        assert_equal 0, player1.points
        assert_equal 'love', player1.points_call 
        player1.win_point
        assert_equal 1, player1.points
        assert_equal '15', player1.points_call 
        player1.win_point
        assert_equal 2, player1.points
        assert_equal '30', player1.points_call
        player1.win_point
        assert_equal 3, player1.points
        assert_equal '40', player1.points_call
        player1.win_point
        assert_equal 4, player1.points
        assert_equal player1.valid_call?, false
    end

    def test_unique_names
        player1 = Player.new('player1')
        player2 = Player.new('player1')
        assert_raise(ArgumentError) do
            game = Game.new(player1, player2)
        end
    end

    def test_game
        player1 = Player.new('player1')
        player2 = Player.new('player2')
        game = Game.new(player1, player2)
        assert_equal '0-0', game.score
        player1.win_point
        assert_equal '15-love', game.score
        player2.win_point
        assert_equal '15-15', game.score
        player1.win_point
        player1.win_point
        assert_equal '40-15', game.score
        player2.win_point
        player2.win_point
        assert_equal 'Deuce', game.score
        player1.win_point
        assert_equal 'Advantage player1', game.score
        player1.win_point
        assert_equal player1, game.winner
    end

    def test_one_sided_match
        match = Match.new('player 1', 'player 2')
        match.pointWonBy('player 1')
        match.pointWonBy('player 2')
        assert_equal '0-0, 15-15', match.score
        match.pointWonBy('player 1')
        match.pointWonBy('player 1')
        assert_equal '0-0, 40-15', match.score
        match.pointWonBy('player 2')
        match.pointWonBy('player 2')
        assert_equal '0-0, Deuce', match.score
        match.pointWonBy('player 1')
        assert_equal '0-0, Advantage player 1', match.score
        match.pointWonBy('player 1')
        assert_equal '1-0, 0-0', match.score
        5.times do 
            match.pointWonBy('player 1')
        end
        assert_equal '2-0, 15-love', match.score
        15.times do 
            match.pointWonBy('player 1')
        end
        assert_equal '6-0, 0-0', match.score 
    end

    def test_match_deuce
        match = Match.new('player 1', 'player 2')
        3.times do 
            match.pointWonBy('player 1')
            match.pointWonBy('player 2')
        end
        assert_equal '0-0, Deuce', match.score
        match.pointWonBy('player 1')
        assert_equal '0-0, Advantage player 1', match.score
        match.pointWonBy('player 2')
        assert_equal '0-0, Deuce', match.score
        match.pointWonBy('player 2')
        assert_equal '0-0, Advantage player 2', match.score
        match.pointWonBy('player 1')
        assert_equal '0-0, Deuce', match.score
        match.pointWonBy('player 2')
        match.pointWonBy('player 2')
        assert_equal '0-1, 0-0', match.score
    end

    def test_match_close_set
        match = Match.new('Foo', 'Bar')
        assert_equal match.set.game.tie_break, false
        5.times do
            5.times do 
                match.pointWonBy('Foo')
            end
            5.times do 
                match.pointWonBy('Bar')
            end
        end
        assert_equal '5-5, love-15', match.score
        3.times do 
            match.pointWonBy('Bar')
        end
        assert_equal '5-6, 0-0', match.score
        assert_equal match.set.game.tie_break, false
        4.times do 
            match.pointWonBy('Foo')
        end
        assert_equal '6-6, 0-0', match.score
        assert_equal match.set.game.tie_break, true
        5.times do 
            match.pointWonBy('Foo')
        end
        assert_equal '6-6, 5-0', match.score
        5.times do 
            match.pointWonBy('Bar')
        end
        assert_equal '6-6, 5-5', match.score
        match.pointWonBy('Foo')
        match.pointWonBy('Bar')
        assert_equal '6-6, 6-6', match.score
        10.times do
            match.pointWonBy('Foo')
            match.pointWonBy('Bar')
        end 
        assert_equal '6-6, 16-16', match.score
        match.pointWonBy('Bar')
        match.pointWonBy('Bar')
        assert_equal '6-7, 0-0', match.score

    end

end