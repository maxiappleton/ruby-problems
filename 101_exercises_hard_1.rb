# Exercises - Hard 1

# Question 1

# I think it will give an error that greeting is not defined...
# and of course I'm wrong! It's nil. That seems strange, but okay.

# Question 2

# The last line of this code is "hi there", because 'informal greeting'
# points to the original object 'greetings'. The method '<<' mutates
# the original object.  

# Question 3

# In code example A)
#   puts "one is: one"
#   puts "two is: two"
#   puts "three is: three"

#   This is because when the variables one, two, and three are changed
#   in the method with the = operator, which creates a new copy of the
#   variables that are seperate from the variables outside the method.

# In code example B)
#   puts "one is: one"
#   puts "two is: two"
#   puts "three is: three"

#   This is for the same reasons as in example A. The variables 'one',
#   'two', and 'three' in the method are new copies of the string, so
#   the variables outside are the same when called.

# In code example C)
#   puts "one is: two"
#   puts "two is: three"
#   puts "three is: one"

#   This is because the .gsub! method directly mutates the object
#   at the object id/reference that is passed in to the variable.

# Question 4

def create_uuid
  SecureRandom.uuid
end

# Question 5

# Here's how I fixed it:

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4
  dot_separated_words.each do |num|
    return false if is_an_ip_number(num) == false
  end  
  true
end



