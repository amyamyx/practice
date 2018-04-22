require_relative 'board'
require_relative 'player'

class MemoryPuzzle

  def initialize(player, board = Board.emyty_grid)
    @player = player
    @board = board
    @guessed_pos = []
  end

  def play
    until over?
      system('clear')
      @board.render
      play_round
    end
  end

  def play_round
    print "Enter a pos, ex. 1,2: "
    guess1 = player.get_guess

    until valid_guess?(guess1)
      player.alert_invalid_guess
      guess1 = player.get_guess
    end
    reveal(guess1)

    print "Enter another pos, ex. 0,2: "
    guess2 = player.get_guess

    until valid_guess?(guess2)
      player.alert_invalid_guess
      guess2 = player.get_guess
    end
    @board.reveal(guess2)
    update_guessed_pos(guess1, guess2)

    handle_guesses(guess1, guess2)
  end

  def valid_guess?
  end


  def over?
  end

end
