require_relative 'board'
require_relative 'player'

class MemoryPuzzle

  attr_reader :num_of_hearts, :player, :board

  def initialize(player, board = Board.empty_grid)
    @player = player
    @board = board
    @guessed_pos = []
    @num_of_hearts = 7
  end

  def play
    @board.populate
    play_round until over?

    if @board.won?
      puts ""
      puts "Congrats, #{player.name}! You won!"
    else
      puts ""
      puts "Opps! You are out of moves!"
    end
  end

  def play_round
    display
    print "Enter a pos, ex. 1,2: "
    guess1 = player.get_guess

    until valid_guess?(guess1)
      print "This card is alreay face_up. Try again: "
      guess1 = player.get_guess
    end
    @board.reveal(guess1)
    display
    print "Enter another pos, ex. 0,2: "
    guess2 = player.get_guess

    until valid_guess?(guess2)
      print "This card is alreay face_up. Try again: "
      guess2 = player.get_guess
    end

    @board.reveal(guess2)
    display
    update_guessed_pos(guess1, guess2)
    handle_guesses(guess1, guess2)
  end

  def valid_guess?(pos)
    !@board[pos].face_up
  end

  def update_guessed_pos(*guesses)
    guesses.each do |guess|
      @guessed_pos << guess unless @guessed_pos.include?(guess)
    end
  end

  def handle_guesses(pos1, pos2)
    card1, card2 = @board[pos1], @board[pos2]
    if card1 == card2
      puts "Good job! Keep going."
    else
      puts "You missed it. Keep trying!"
      @num_of_hearts -= 1
      card1.hide
      card2.hide
    end
    sleep(2)
  end

  def over?
    @board.won? || @num_of_hearts == 0
  end

  def display
    system("clear")
    @board.render
    puts ""
    puts "You have #{@num_of_hearts} hearts remaining."
    puts ""
  end
end


if __FILE__ == $PROGRAM_NAME
  print "Enter your name: "
  name = gets.chomp
  player = Player.new(name)
  game = MemoryPuzzle.new(player)
  game.play
end
