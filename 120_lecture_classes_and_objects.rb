# Lecture - Classes and Objects

# Question 1

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end  
end  

# Question 2

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(fname, lname='')
    @first_name = fname
    @last_name = lname
  end

  def name
    @first_name + ' ' + @last_name
  end  
end

# Question 3

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(fullname)
    parse_full_name(fullname)
  end

  def name
   "#{first_name} #{last_name}".strip
  end

  def name=(fullname)
    parse_full_name(fullname)
  end

  private

  def parse_full_name(fullname)
    names = fullname.split
    self.first_name = names.first
    self.last_name = names.size > 1 ? names.last : ''
  end  
end

# Question 4

bob.name == rob.name

# Question 5

"The person's name is: #<Person:0x007ff42c87e088>"








