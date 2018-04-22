require_relative "player"

class Ghost
  attr_reader :players, :current_player, :previous_player, :fragment, :dictionary
  attr_accessor :losses

  GHOST = ["G", "H", "O", "S", "T"]

  def initialize(players)
    @players = players
    @fragment = ""
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @losses = Hash.new {|h, k| h[k] = 0}
  end

  def prep
    players.each { |player| losses[player] }
    @current_player = players[0]
  end

  def run
    prep
    until losses.values.include?(5)
      display_record
      play_round
    end
    display_record
    puts ""
    puts "#{previous_player.name} lost!"
  end

  def play_round
    @fragment = ""

    until @dictionary.include?(@fragment)
      display_fragment
      take_turn(current_player)
      update_dictionary(@fragment)
      next_player!
    end

    puts "Ahhh, #{@fragment.upcase} is a word! #{@previous_player.name} earned a LETTER!"
    losses[previous_player] += 1
  end

  def next_player!
    @previous_player = current_player
    @current_player = players[next_player_idx]
  end

  def take_turn(player)
    print "#{player.name}, it's your turn: "
    guess = player.guess

    unless valid_play?(guess)
      player.alert_invalid_guess
      guess = player.guess
    end

    @fragment.concat(guess)
  end

  def valid_play?(str)
    temp_frag = @fragment + str
    @dictionary.any? do |word|
      word[0...temp_frag.length] == temp_frag
    end
  end

  def update_dictionary(frag)
    @dictionary.select { |word| word[0...frag.length] == frag }
  end

  def record(player)
    num = losses[player]
    GHOST.take(num).join
  end

  def display_record
    puts ""
    puts "Records:"
    players.each do |player|
      puts "   #{player.name}: #{record(player)}"
    end
  end

  def display_fragment
    puts ""
    puts "Current fragment: #{@fragment}"
  end

  def current_player_idx
    players.index(current_player)
  end

  def next_player_idx
    current_player_idx == players.size - 1 ? 0 : current_player_idx + 1
  end
end


if __FILE__ == $PROGRAM_NAME
  print "Enter player1's name: "
  name1 = gets.chomp
  print "Enter player2's name: "
  name2 = gets.chomp
  player1 = Player.new(name1)
  player2 = Player.new(name2)

  game = Ghost.new([player1, player2])
  game.run
end
