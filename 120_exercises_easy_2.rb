
# Exercises - Easy 2

# Question 1

# The result of calling this will be a string object of "You will" followed by one of the three strings in the array in the method 'choices' chosen at random by '.sample'.

# Question 2

# The result will be a sentence completed by one of the three phrases in the choices method in the RoadTrip class (as it overrides the choices method in the superclass Oracle). It is encountered first in the lookup path.

# Question 3

# You can lookup the order of classes/modules in which Ruby will look for a method by calling '.ancestors' on a class (remember it is ONLY a class method, not an instance method).

# The order of lookup for HotSauce is -> 'HotSauce, Taste, Object, Kernel, BasicObject' and for Orange it is 'Orange, Taste, Object, Kernel, BasicObject'. 

# Question 4

# I would add 'attr_accessor' and remove the two 'type' and 'type=(t)' methods.

# Question 5

# The first is a local variable, the second is an instance variable because it has an @ sign before it, and the third is a class variable because it has @@ before it.

# Question 6

# The 'self.manufacturer' is a class method because it has the 'self.' prefixed to the method name. You call a class method on the class name itself. E.g. Class.class_method

# Question 7

# The @@cats_counts class variable tracks the number of class instances (objects) that have been created from the Cat class. 

# Question 8

# We could simply addend < Game to the class name Bingo, so it will inherit.

# Question 9

# The new play method in the Bingo class would override the play method in the Game superclass because it is encountered first in the lookup chain.

# Question 10

# So many!



