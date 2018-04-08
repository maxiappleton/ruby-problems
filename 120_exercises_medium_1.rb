
# Exercises - Medium 1

# Question 1

# Ben is correct because of the attr_reader at the top of the class. This allows him to write 'balance' without the @ and it acts as a method call to retrieve the value of @balance. So it amounts to the same thing. 

# Question 2

# The mistake is that '@quantity' is only given a getter attr_reader method, NOT a setter method, which would require attr_writer or attr_accessor. But THEN would have to use 'self.quantity' = ...etc. Or just access the variable directly using @quantity. 

# Question 3

# It opens up the possibility of altering the @quantity value via multiple means (other than the update_quantity method).

# Question 4

class Greeting
  def greet(string)
    puts string
  end  
end

class Hello < Greeting
  def hi
    greet("Hello")
  end  
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end  
end

# Question 5

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    filling_string = @filling_type ? @filling_type : "Plain"
    glazing_string = @glazing ? " with #{@glazing}" : ''
    filling_string + glazing_string
  end
end

# Question 6

# OH! The SETTER method always requires 'self.' but the GETTER method doesn't! That's what I've been missing.

# Anyhow, they output the same result. You CAN use self.getter, but I guess Ruby prefers you to avoid using '.self' unless required (as with the setter methods). 

# Question 7

# You could change it to 'self.information', so it would becoe 'Light.information' when called on the class. Better readability.

