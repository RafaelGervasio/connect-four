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
    def board_full?
        flat_board = self.board.flatten
        flat_board.none? {|elem| elem == 'empty'}
    end
    def check_horiz?
        count = 0
        check = false
        self.turn == self.p1 ? symbol = 'X' : symbol = 'O'
        self.board.each do |row|
            row.each do |value|
                value == symbol ? count+=1 : count = 0
                count >= 4 ? check = true : ''
            end
        end
        check
    end
    def check_vert?
        self.turn == self.p1 ? symbol = 'X' : symbol = 'O'
        check = false
        i = 0
        while i < 7 do
            new_arr = self.board.map {|row| row[i]}
            count = 0
            new_arr.each do |elem|
                elem == symbol ? count+=1 : count = 0
                count >= 4 ? check = true : ''
            end
            i+=1
        end
        check
    end
    def check_diag_right(row, collumn)
        self.turn == self.p1 ? symbol = 'X' : symbol = 'O' 
        count = 0

        until board[row].nil? || board[row][collumn].nil?
            board[row][collumn] == symbol ? count+=1 : count = 0
            count == 4 ? check = true : ''
            collumn+=1
            row -= 1
        end
        check
    end

    def check_diag_left (row, collumn)
        self.turn == self.p1 ? symbol = 'X' : symbol = 'O' 
        count = 0

        until board[row].nil? || board[row][collumn].nil?
            board[row][collumn] == symbol ? count+=1 : count = 0
            count == 4 ? check = true : ''
            collumn-=1
            row -=1
        end
        check
    end


    def check_diag?
       check = false
       func_check = false

       row = -1
       collumn = 0 
       4.times do 
            if check_diag_right(row, collumn) == true
                func_check = true
            end

            row = -1
            collumn+=1
        end

        row = -1
        collumn = 3
        4.times do
            if check_diag_left(row, collumn) == true
                func_check = true
            end
            row = -1
            collumn += 1
        end

        func_check
    end
    def game_over?
        return true if board_full?() || check_horiz?() || check_diag?() || check_vert?()
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


