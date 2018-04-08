class Diamond
  def self.make_diamond(mid_letter)
    size = (mid_letter.ord - 65)*2 + 1
    half = size / 2
    result = ''

    size.times do |num|
      num = num - 2*(num-half) if num > half
      mid_gap = (num*2) - 1

      row = if num.zero? || num == size-1
              "65".center(size+1)
            else
              "#{65+num}#{' '*mid_gap}#{65+num}".center(size+2)
            end

      result << (row + "\n")
    end

    result.gsub(/\d+/) { |num| num.to_i.chr }
  end
end