def sum_to(n)
  return nil if n <= 0
  return n if n == 1

  n + sum_to(n - 1)
end

def add_numbers(nums_array)
  return nil if nums_array.empty?
  first = nums_array.first
  return first if nums_array.length == 1

  first + add_numbers(nums_array.drop(1))
end

def gamma_fnc(n)
  return nil if n == 0
  return 1 if n == 1

  (n - 1) * gamma_fnc(n - 1)
end

def factorial(n)
  return nil if n < 0
  return 1 if n <= 1

  n * factorail(n - 1)
end

def ice_cream_shop(inventory, fav_flavor)
  return false if inventory.empty?
  first = inventory.first
  return true if inventory.length == 1 && first == fav_flavor
  first == fav_flavor || ice_cream_shop(inventory.drop(1), fav_flavor)
end

def reverse(str)
  return str if str.length <= 1

  reverse(str[1..-1]) + str[0]
end
