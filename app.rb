module Board
    attr_accessor :board

    def create_board
        @board = []
        6.times {board.push(['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty'])}
        board
    end
    def display_board
        puts "--- Game Board ---"
        board.each {|row| p row}
    end
    def update_board (collumn)
        updated = false
        self.board.each_with_index do |row, i|
            if row[collumn - 1] == 'empty'
                next
            else
                p i
                self.turn == self.p1 ? self.board[i-1][collumn - 1] = 'X' : self.board[i-1][collumn - 1] = 'O'
                updated = true
                break
            end
        end
        if updated == false
            self.turn == self.p1 ? self.board[-1][collumn - 1] = 'X' : self.board[-1][collumn - 1] = 'O'
        end
        self.board
    end
end

module Player
    attr_accessor :p1, :p2, :turn
    def initialize
        @p1 = nil
        @p2 = nil
        @turn = nil
    end

    def create_player
        puts "What's your name?"
        name = gets.chomp
        self.p1.nil? ? self.p1 = name : self.p2 = name
    end

    def decide_starter
        random_nr = rand(2)
        random_nr == 0 ? self.turn = self.p1 : self.turn = self.p2
    end

    def change_turn
        self.turn == self.p1 ? self.turn = self.p2 : self.turn = self.p1
    end

    def make_move
        puts "What collumn do you want to drop your disk in?"
        user_input = gets.chomp.to_i
        update_board(user_input)
    end
end


class Game
    include Board
    include Player
end


# gm = Game.new
# gm.create_board
# gm.create_player
# gm.make_move
# gm.display_board