class Game

    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6] 
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
        @board.display
    end

    def current_player
        board.turn_count.even? ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.find do |combo|
            board.cells[combo[0]] == board.cells[combo[1]] && board.cells[combo[1]] == board.cells[combo[2]] && board.cells[combo[0]] != " "
        end
    end

    def draw?
        board.full? && !won?
    end

    def over?
        draw? || won? ? true : false
    end

    def winner
        board.cells[won?[0]] if won?
    end

    def turn
        puts "Where would you like to move from 1-9: "
        input = current_player.move(@board)
        if @board.valid_move?(input)
            @board.update(input, current_player)
        else puts "Where would you like to move from 1-9:"

            @board.display
        else puts "Enter a number from 1-9: "
            turn
        end
        @board.display
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
        @board.display
    end

end