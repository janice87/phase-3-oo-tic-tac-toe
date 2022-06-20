class TicTacToe
#    attr_reader :board ??
   WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8],
    [0,3,6], 
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
   ]

    def initialize
        @board = [" "," "," "," "," "," "," "," "," "]
    end

    def display_board       
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
    
    def input_to_index(user_input) # the parameter user_input must match where ever else we are calling it too
        user_input.to_i - 1
    end

    # game.move(0, "X")
    # game.move(4, "O")
    # ["X", " ", " ", " ", "O", " ", " ", " ", " "]
    def move(index, token="X")
        @board[index] = token
    end

    # will be run after input_to_index
    # board = ["X", " ", " ", " ", " ", " ", " ", " ", "O"]
    # index = 0 true   
    # index = 1 false   
    def position_taken?(index)  
        @board[index] == " " ? false : true   
    end
    # @board[index] != " " # returns true, this also works
    # if the given index is not " " then true

    # board = [" ", " ", " ", " ", "X", " ", " ", " ", " "]
    # index = 0 truthy
    # index = 4 falsey
    def valid_move?(index)
        @board[index] == " " && index.between?(0,8) # index >= 0 && index <= 8
        # !position_taken?(index) && index.between?(0,8) # also works
        # @board[index] == " " && index == (0..8) # range (0..8) doesn't work? why?
    end
    # 1.between?(1, 5) true
    # 3.between?(1, 5) true

    # returns the # of turns based on the board
    # board = ["O", " ", " ", " ", "X", " ", " ", " ", "X"] 3
    # board = ["O", " ", "O", " ", "X", " ", " ", " ", "X"] 4
    def turn_count
        @board.count {|token| token != " "} #sum wouldn't work bc we don't want a total
    end

    # returns the correct player, X, for the third move
    # returns the correct player, O, for the fourth move
    # X 1, O 2, X 3 when the turn count is 2 that means X is next
    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn        
        puts "Enter a number (1-9):"
        user_input = gets.strip # user_input gets passed into method below and the parameters must match the method
        index = input_to_index(user_input) #user_input parameter must match from method above
        if valid_move?(index)
            token = current_player #test calls current_player method and it returns X or O, we then pass the token param into move below
            move(index, token) # token is current_player param from above and must match 
            display_board          
        else         
            turn # recursion calling a method from inside itself
        end
        #display_board # or after the if block
    end
    
    def won?  
        WIN_COMBINATIONS.any? do |winning_array|  
            if position_taken?(winning_array[0]) && @board[winning_array[0]] == @board[winning_array[1]] && @board[winning_array[1]] == @board[winning_array[2]]
            return winning_array
            end
        end
    end
    # WIN_COMBINATIONS = [ [0, 1, 2], [], ... ] iterate thru [] of []
    # winning_array is [0, 1, 2]
    # if position_taken?(index) is true aka the position is taken AND the X or O match 
    # board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
    # @board[winning_array[0]] returns X and if this is equal to below
    # @board[winning_array[1]] returns X, @board[winning_array[2]] returns X and if they both are = return the winning_array
    
    def full?
        @board.all? {|token| token != " "} # .all returns whether every element meets a given criteria
        #.any? would not work bc if theres a game in progess it would be " "
        # turn_count >= 9 # this works too
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
        # won? || full? per readme, but says ie is a draw
    end
   
    def winner       
         if combo = won? # if returns true, otherwise nil. combo is returning the winning combo
         @board[combo[0]] # this returns the X or O on the board who won
        end
    end
    # need the if bc it should return nil if no winner

    def play
        until over?
            turn
        end

       if won?
           puts "Congratulations #{winner}!"
       elsif draw?
           puts "Cat's Game!"
        end        
    end

end

