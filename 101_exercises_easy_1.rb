# Exercises - Easy 1

# Question 1

# I would expect it to output 1, 2, 3, 4, because .uniq does not modify the original array.

# Question 2

# The meaning of ! and ? changes depending on the scenario.

# 1. That means NOT equal to, you should use it when comparing values.
# 2. Turns it into the opposite boolean.
# 3. It changes the method to mutate the caller permanently.
# 4. Not sure?
# 5. That usually indicates a method will return a true or false value.
# 6. Not sure?

# Question 3

advice.gsub('important', 'urgent')

# Question 4

numbers.delete_at(1) # deletes at the INDEX location 1 (which happens to be the second value in this array)

numbers.delete(1) # deletes the actual value of '1' in this array.

# Question 5

(10..100).include?(42)

# Question 6

  # Method 1
  famous_words.insert(0, "Four score and ")

  #Method 2
  famous_words.prepend("Four score and ")

# Question 7

# The answer to that riciculous method call will be 42
 # 2 + 8 = 10 + 8 = 18 + 8 = 26 + 8 = 34 + 8 = 42

# Question 8

flintstones.flatten

# Question 9

flintstones.to_a[2] 
# or apparently 
flintstones.assoc("Barney")

# Question 10

flintstones_hash = Hash.new
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end  

