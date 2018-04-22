class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_guess
    input = gets.chomp

    until valid_input?(input)
      alert_invalid_input
      input = gets.chomp
    end
    input.split(",").map(&:to_i)
  end


  def valid_input?(input)
    nums = (0..9).map(&:to_s)
    input = input.split(",")
    b = input.all? { |el| nums.include?(el) }
    c = (input[0].to_i).between?(0, 3) && (input[1].to_i).between?(0, 4)
    b && c
  end

  def alert_invalid_input
    puts "Invalid input."
    print "Did you use a comma (ex. 1,2)? Try again: "
  end

end
