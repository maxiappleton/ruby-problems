# Exercises - Easy 2

# Question 1

ages.has_key?("Spot")
ages.include?("Spot")
ages.member?("Spot")

# Question 2

total = 0
ages.each_value { |age| total += age }

  # OR

  ages.values.inject(:+)

# Question 3

ages.delete_if { |_, age| age > 99 }

# Question 4

  # First conversion
    munsters_description.capitalize!

  # Second conversion
    munsters_description.swapcase!

  # Third conversion
    munsters_description.downcase!

  # Fourth conversion
    munsters_description.upcase!

# Question 5

ages.merge(additional_ages)

# Question 6

ages.values.min

# Question 7

advice.include?("Dino")
# or
advice.match("Dino")

# Question 8

flintstones.index { |name| name[0, 2] == "Be" }

# Question 9

flintstones.map! do |name|
  name.slice(0,3)
end

# Question 10

flintstones.map { |name| name.slice(0,3) }

