class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    input = gets.chomp
  end

  def alert_invalid_guess
    print "It's not a valid input. Try again: "
  end
end
