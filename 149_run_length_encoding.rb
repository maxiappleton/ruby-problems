class RunLengthEncoding
  def self.encode(input)
    input
      .chars
      .chunk_while { |ele1, ele2| ele1 == ele2 }
      .map { |ltrs| ltrs.size == 1 ? ltrs.first : "#{ltrs.size}#{ltrs.first}" }
      .join
  end

  def self.decode(input)
    input
      .scan(/\d+\D|\D/)
      .map { |code| code.size == 1 ? code : code[-1]*code.to_i }
      .join
  end
end