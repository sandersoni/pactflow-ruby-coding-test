class Player
    attr_accessor :name, :points, :games, :sets

    # In tennis, the "love, 15, ..." is the "call" of the point
    POINTS_TO_CALL = ['love', '15', '30', '40']

    def initialize(name)
        @name = name
        @points = 0
        @games = 0
        @sets = 0
    end
   
    def win_point
        @points += 1
    end

    def win_game
        @games += 1
    end

    def win_set
        @sets += 1
    end
    
    def valid_call?
        return false if @points < 0 || @points > POINTS_TO_CALL.length - 1 
        true
    end

    def points_call
        "#{POINTS_TO_CALL[@points]}"
    end 

end

if __FILE__ == $PROGRAM_NAME
    puts "This class is not meant to be run directly."
    puts "if you want to run a match of tennis, run match.rb."
  end