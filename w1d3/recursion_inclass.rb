require 'byebug'
def range(start, finish)
  retrun nil if finish < start
  return [] if start == finish

  [start] + range(start + 1, finish)
end

def sum_arr_rec(nums)
  return 0 if nums.empty?
  first = nums.first
  return first if nums.length == 1

  first + sum_arr_rec(nums.drop(1))
end

def sum_arr_iter(nums)
  nums.reduce(:+)
end

def exp1(base, n)
  return 1 if n == 0
  return base if n == 1

  base * exp1(base, n - 1)
end

def exp2(base, n)
  return 1 if n == 0
  return base if n == 1

  if n.even?
    exp2(base, n / 2) ** 2
  else
    base * (exp2(base, (n - 1) / 2) ** 2)
  end
end

class Array

  def deep_dup
    return [] if empty?

    if first.is_a?(Array)
      [first.deep_dup] + self[1..-1].deep_dup
    else
      [first] + self[1..-1].deep_dup
    end
  end
end

def fib(n)
  return [0] if n == 1
  return [0, 1] if n == 2

  prev = fib(n - 1)
  prev << prev[-1] + prev[-2]
end

def bsearch(arr, target)
  return nil if arr.empty?

  mid_i = arr.length / 2

  case  arr[mid_i] <=> target
  when 0
    mid_i
  when 1
    bsearch(arr[0...mid_i], target)
  else
    right = bsearch(arr[mid_i + 1..-1], target)
    mid_i + right + 1 unless right.nil?
  end
end

def merge_sort(arr, &prc)
  return arr if arr.length <= 1

  mid_i = arr.length / 2
  left = merge_sort(arr.take(mid_i), &prc)
  right = merge_sort(arr.drop(mid_i), &prc)

  merge(left, right, &prc)
end

def merge(left, right, &prc)
  prc ||= Proc.new { |a, b| a <=> b}
  merged = []

  until left.empty? || right.empty?
    if prc.call(left.first, right.first) == 1
      merged << right.shift
    else
      merged << left.shift
    end
  end

  merged + left + right
end

def subsets(arr)
  return [[]] if arr.empty?

  left = subsets(arr[0...-1])
  right = left.map { |el| el << arr.last }

  left + right
end

def permutations(arr)
  return [arr] if arr.length <= 1
  result = []

  prev = permutations(arr[0...-1])

  prev.each do |el|
    arr.length.times do |i|
      result << el.take(i) + [arr.last] + el.drop(i)
    end
  end

  result
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0 || coins.empty?
  change = []

  if amount < coins.first
    remainder = amount
    coins2 = coins.drop(1)
  else
    change << coins.first
    remainder = amount - coins.first
    coins2 = coins
  end

  change + greedy_make_change(remainder, coins2)
end

p greedy_make_change(14, [10, 7, 1])

def make_better_change(amount, coins = [25, 10, 5, 1])
  debugger
  return [] if amount == 0
  return nil if coins.all? { |coin| coin > amount}
  coins = coins.sort.reverse

  best_change = nil

  coins.each_with_index do |coin, i|
    next if coin > amount

    remainder = amount - coin
    best_remainder = make_better_change(remainder, coins.drop(i))
    next if best_remainder.nil?

    this_change = [coin] + best_remainder

    if best_change.nil? || best_change.size > this_change.size
      best_change = this_change
    end
  end

  best_change
end


p make_better_change(24, [10, 7, 1])
