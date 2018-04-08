# Exercises - Medium 1

# Question 1

10.times do |i|
  i.times { putc "  " } 
  puts "The Flintstones Rock!"
end

# Question 2

statement = "The Flintstones Rock"
letters_hash = Hash.new
char_array = statement.delete(' ').chars.uniq
char_array.each do |letter|
  letters_hash[letter] = statement.count(letter)
end

# Question 3

puts "the value of 40 + 2 is " + (40 + 2)

# This causes an error because you are trying to attach a 
# 'fixnum' (40 + 2) to a 'string'. 
# Two possible ways to fix it are one - type conversion:

puts "the value of 40 + 2 is " + (40 + 2).to_s

# And two - string interpolation:

puts "the value of 40 + 2 is " + "#{(40 + 2)}"

# Question 4

# For the first attempt to modify an array during a loop,
# the loop still references the index numbers of the array,
# despite it changing in size.

# So on the first loop, it would p '1', then remove '1' from
# the array. The array would be [2, 3, 4], and the each loop would
# be at index '1'. On the second loop through, it would 'p' 3, because
# now that is at index '1', and remove '2'. So the array would now
# be [3, 4]. The loop would be at index 2, but would find no index
# 2 in the array [3, 4], so would end there.

# Short answer: 1 and 3 would be output.

# For the second gist of code: on the first loop through, index
# location = 0, it would p '1' to the screen, and '4' would be removed.
# Second loop through, array would be [1, 2, 3] index location = 1,
# p will put '2' to the screen, and 'pop' off 3. Array would be [1, 2],
# the loop would attempt to continue with index location 2, but would
# not find it and the loop would end there.

# Short answer: 1 and 2 would be output.

# Question 5

def factors(number)
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors
end

  # Bonus 1 - the "number % dividend == 0" statement tells us that the
  # given number divides by the divdend with no remainder, so must be
  # a divisor.

  # Bonus 2 - the second to last line ensures that the divisors array
  # is returned as the last line in the method.

# Question 6

# YES there is a difference! In rolling_buffer1, the input argument
# 'buffer' is being directly mutated with the << method. Whereas
# in rolling_buffer2, it is not. 

# Question 7

LIMIT = 15

def fib(first_num, second_num)
  while second_num < LIMIT
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

# What was wrong with the code was that the 'fib' method had no way to
# access the 'limit' variable as it was not passed in to the method.

# There are a couple of ways to potentially fix this:

# 1. Make 'limit' a CONSTANT so it is accessible by all methods.
# 2. Make 'limit' a global variable (but I don't think we've covered
# that yet and maybe it's not a good idea?)
# 3. Add a third parameter to fib called 'limit' and pass it in
# when initialized on line 95.

# Question 8

string = "let's titleize this sentence!"
string.split(' ').each { |w| w.capitalize! }.join(' ')

# Question 9

munsters.each do | _ , v|
  case v["age"]
  when 0..17
    v["age_group"] = "kid"
  when 18..64
    v["age_group"] = "adult"
  else
    v["age_group"] = "senior"
  end
end









