# Lecture - Classes and Objects

# Question 1

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

# Question 2

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def speak
    'bark!'
  end
end

class Cat < Pet
end  

class Dog < Pet
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

# Question 3

    Pet
     |
   -----
  |     |
 Dog   Cat
  |
Bulldog

# Question 4

# The method lookup path is the order of classes and modules in which Ruby looks for a method to excecute on an object. It is important because of the potential for methods earlier in the lookup path to override methods of the same name that are found later in the look up path.






