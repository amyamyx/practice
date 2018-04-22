class Card
  attr_reader :value
  attr_accessor :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def hide
    @face_up = false
  end

  def to_s
    face_up ? @value.to_s : " "
  end

  def ==(another_card)
    @value == another_card.value
  end

end
