# rubocop:disable
module Enumerable
  def my_each
	return to_enum unless block_given?
	arr = to_a
	i = 0
     while i < arr.length
	  yield(arr[i])
	  i += 1
    end
  end
end

# ...1...
p(1...5).my_each { |num| puts "the number is #{num}" }
p %w[Sharon Leo Leila Brian Arun].my_each { |friend| puts "Hello, #{friend}" } # rubocop:disable
