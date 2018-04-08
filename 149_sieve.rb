class Sieve
  def initialize(limit)
    @limit = limit
  end

  def primes
    initial_range = (2..@limit).to_a
    working_range = initial_range

    initial_range.each do |num1|
      working_range.delete_if do |num2|
        num2 % num1 == 0 unless num2 == num1
      end
    end

    working_range
  end  
end