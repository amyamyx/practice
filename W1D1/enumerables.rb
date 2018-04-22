require 'byebug'
class Array

  def my_each(&prc)
    self.length.times { |i| prc.call(self[i]) }

    self
  end

  def my_select(&prc)
    selected = []

    self.my_each do |el|
      selected << el if prc.call(el)
    end

    selected
  end

  def my_reject(&prc)
    selected = []

    self.my_each do |el|
      selected << el unless prc.call(el)
    end

    selected
  end

  def my_any?(&prc)
    self.my_each { |el| return true if prc.call(el) }
    false
  end

  def my_flatten
    flattened = []

    self.my_each do |el|
      if el.is_a?(Array)
        flattened += el.my_flatten
      else
        flattened << el
      end
    end

    flattened
  end

  def my_zip(*args)
    zipped = Array.new(length) {Array.new(args.length + 1)}

    (0...length).to_a.my_each { |i| zipped[i][0] = self[i] }

    length.times do |i|
      args.length.times do |args_i|
        zipped[i][args_i + 1] = args[args_i][i]
      end
    end

    zipped
  end

  def my_rotate(offset = 1)
    offset %= length

    drop(offset) + take(offset)
  end

  def my_join(separator = "")
    joined = ""

    length.times do |i|
      add = i == length - 1 ? self[i].to_s : self[i].to_s + separator
      joined << add
    end

    joined
  end

  def my_reverse
    reversed = []
    self.my_each { |el| reversed.unshift(el) }
    reversed
  end

end

def factors(num)
  (1..num).select { |i| num % i == 0}
end

class Array

  def bubble_sort!(&prc)
    prc ||= Proc.new { |a, b| a <=> b }
    sorted = false

    until sorted
      sorted = true

      (length - 1).times do |i|
        if prc.call(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def substrings(str)
  substrings = []
  (0...str.size).to_a.my_each do |i|
    (i...str.size).to_a.my_each do |j|
      substrings << str[i..j]
    end
  end
  substrings
end

def sub_words(word, dictionary)
  sub_strs = substrings(word)
  sub_strs.select { |str| dictionary.include?(str)}
end
