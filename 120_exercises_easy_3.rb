
# Exercises - Easy 3

# Question 1

# Case 1 - print "Hello"
# Case 2 - error, cannot find method
# Case 3 - error, 1 argument expected, 0 recieved
# Case 4 - print "Goodbye"
# Case 5 - Error, cannot find class method '.hi'

# Question 2

# You could make 'hi' a class method by changing its name to 'self.hi'. And then instatiating a new Greeting object in that method, and calling '.greet("Hello") on that object. A little cumbersome. 

# Question 3

# cat1 = AngryCat.new(5, 'Kitty')
# cat2 = AngryCat.new(7, 'Kat')

# Question 4

# add the following instance method to the class:

def to_s
  "I am a #{type} cat"
end

# AND remember to add the attr_reader :type tag so that 'type' can be accessed.

# Question 5

# The 'tv.manufacturer' would raise an error, because you're trying to call a class method on an instance of a class. Also the 'Television.model' would raise an error because you're trying to call a instance method on a class.

# Question 6

# You could also write this method just using '@age'. It would function the same way.

# Question 7

# The self.information class method is largely useless and doesn't do what you would assume it would. Oh, and the redundant 'return' on line 10. 

