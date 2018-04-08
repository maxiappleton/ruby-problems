# Exercises - Medium 2

# Question 1

total_age = 0
munsters.each do |k, v|
  total_age += v["age"] if v["gender"] == "male"
end

# Question 2

munsters.each do |k, v|
  puts "#{k} is a #{v["age"]} old #{v["gender"]}"
end

# Question 3

def refactored_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string, my_array = refactored_method(my_string, my_array)

# Question 4

sentence = "Humpty Dumpty sat on a wall."
sentence.split.reverse.join(' ')

# Question 5

# The output is 34! Because you don't even use the new_answer again...
# Tricky!

# Question 6

# The data is overwritten because in the method the values are being
# directly edited.

# Question 7

# When all the other methods are reduced down, you are left with
# "paper"

# Question 8

# The output of the code would be:
# "no"

