class Card
  attr_reader :value
  attr_accessor :revealed

  def initialize(value)
    @value = value
    @revealed = false
  end

  def reveal
    @revealed = true
  end

  def hide
    @revealed = false
  end

  def to_s
    revealed ? @value.to_s : " "
  end

  def ==(another_card)
    @value == another_card.value
  end

end
