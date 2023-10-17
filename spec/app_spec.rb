require './app'

describe Board do
  gm = Game.new
  context 'create_board' do
    it 'creates the game board' do
      expect(gm.create_board).to eql([
                                       %w[empty empty empty empty empty empty empty],
                                       %w[empty empty empty empty empty empty empty],
                                       %w[empty empty empty empty empty empty empty],
                                       %w[empty empty empty empty empty empty empty],
                                       %w[empty empty empty empty empty empty empty],
                                       %w[empty empty empty empty empty empty empty]
                                     ])
    end
  end

  context 'update_board' do
    it 'puts an X in the right collumn and row with an empty board' do
      gm.create_board
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      expect(gm.update_board(3)).to eql(
        [
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty X empty empty empty empty]
        ]
      )
    end
    it 'puts an O in the right collumn and row with an empty board' do
      gm.create_board
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p2
      expect(gm.update_board(3)).to eql(
        [
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty O empty empty empty empty]
        ]
      )
    end

    it 'works for the first collumn on an empty board' do
      gm.create_board
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      expect(gm.update_board(1)).to eql(
        [
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[X empty empty empty empty empty empty]
        ]
      )
    end

    it 'works for the last collumn on an empty board' do
      gm.create_board
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      expect(gm.update_board(7)).to eql(
        [
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty empty],
          %w[empty empty empty empty empty empty X]
        ]
      )
    end
    it 'works for a board with other disks' do
      gm.board = [
        ['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty'],
        ['empty', '', 'empty', 'empty', 'empty', 'empty', 'empty'],
        ['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty'],
        ['empty', 'O', 'X', 'empty', 'empty', 'empty', 'empty'],
        ['empty', 'O', 'X', 'empty', 'empty', 'empty', 'empty'],
        ['empty', 'X', 'X', 'empty', 'empty', 'empty', 'X']
      ]
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      expect(gm.update_board(3)).to eql(
        [
          ['empty', 'empty', 'empty', 'empty', 'empty', 'empty', 'empty'],
          ['empty', '', 'empty', 'empty', 'empty', 'empty', 'empty'],
          ['empty', 'empty', 'X', 'empty', 'empty', 'empty', 'empty'],
          ['empty', 'O', 'X', 'empty', 'empty', 'empty', 'empty'],
          ['empty', 'O', 'X', 'empty', 'empty', 'empty', 'empty'],
          ['empty', 'X', 'X', 'empty', 'empty', 'empty', 'X']
        ]
      )
    end
  end
  context 'board_full?' do
    it 'returns true when board is full' do
      gm.board = [
        ['X', 'X', 'X', 'X', 'X', 'X', 'X'],
        ['X', '', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'X', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'O', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'O', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'X', 'X', 'X', 'X', 'X', 'X']
      ]
      expect(gm.board_full?).to be(true)
    end
    it 'returns false when board is not full' do
      gm.board = [
        ['X', 'X', 'X', 'X', 'X', 'X', 'X'],
        ['X', '', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'X', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'O', 'X', 'X', 'X', 'X', 'X'],
        ['X', 'O', 'X', 'X', 'X', 'X', 'empty'],
        ['X', 'X', 'X', 'X', 'X', 'X', 'X']
      ]
      expect(gm.board_full?).to be(false)
    end
  end
  context 'check_horiz' do
    it 'retruns true when horizontal 4 exists' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      gm.board = [
        %w[X X X empty X X X],
        %w[empty X X X X empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty empty empty empty empty empty]
      ]
      expect(gm.check_horiz).to be true
    end
    it 'retruns false when no horizontal 4 exists' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      gm.board = [
        %w[X X X empty X X X],
        %w[empty X X X empty empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty O X X X empty]
      ]
      expect(gm.check_horiz).to be false
    end
  end
  context 'check_vert' do
    it 'returns true when 4 vertical exist' do
      gm.board = [
        %w[X X X empty X X X],
        %w[X X X X empty empty empty],
        %w[X X empty empty empty empty empty],
        %w[empty X empty empty empty empty empty],
        %w[empty empty empty empty empty empty empty],
        %w[empty empty O X X X empty]
      ]
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      expect(gm.check_vert).to be true
    end
    it 'returns false when no 4 vertical exist' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p2
      expect(gm.check_vert).to be false
    end
  end
end

describe Player do
  gm = Game.new
  context 'create_player' do
    it 'assings name to @p1 when no players exist' do
      gm.p1 = nil
      gm.p2 = nil
      allow(gm).to receive(:gets).and_return('Rafa\n')
      gm.create_player
      expect(gm.p1[0..3]).to eql('Rafa')
    end
    it 'assigns name to @p2 when @p1 exists' do
      gm.p1 = 'Jack'
      gm.p2 = nil
      allow(gm).to receive(:gets).and_return('Rafa\n')
      gm.create_player
      expect(gm.p2[0..3]).to eql('Rafa')
    end
  end

  context 'decide_starter' do
    it 'if rand(2) is 0, player 1 starts' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      allow(gm).to receive(:rand).and_return(0)
      gm.decide_starter
      expect(gm.turn).to eql(gm.p1)
    end
    it 'if rand(2) is 1, player 2 starts' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      allow(gm).to receive(:rand).and_return(1)
      gm.decide_starter
      expect(gm.turn).to eql(gm.p2)
    end
  end

  context 'change_turn' do
    it 'if current turn is p1, it changes it to p2' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p1
      gm.change_turn
      expect(gm.turn).to eql(gm.p2)
    end
    it 'if current turn is p2, it changes it to p1' do
      gm.p1 = 'Rafa'
      gm.p2 = 'Jack'
      gm.turn = gm.p2
      gm.change_turn
      expect(gm.turn).to eql(gm.p1)
    end
  end
end
