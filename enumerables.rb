# rubocop:disable
module Enumerable
  # my_each_Enumberable method
  def my_each
    return to_enum unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    arr
  end

  # my_each_with_index Enumberable method
  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
  end

  # my_select Enumberable method
  def my_select
    return to_enum unless block_given?

    array = []

    my_each { |num| array << num if yield(num) }

    array
  end
end

# ...1...
p(1..5).my_each { |num| puts "the number is #{num}" }
p(%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts "Hello, #{friend}" })

# ..2...
p(%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts friend if index.even? })
p(%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts "#{friend} is index #{index}" })

# ..3...
p(%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' })
