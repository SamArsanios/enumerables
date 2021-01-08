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

  # my_all Enumberable method
  def my_all?(argument = nil)
    if argument
      my_each { |element| return false unless argument === element } # rubocop:disable Style/CaseEquality
    elsif block_given?
      my_each { |element| return false unless yield(element) }
    else
      my_each { |element| return false unless element }
    end
    true
  end

  # my_any Enumberable method
  def my_any?(argue = nil)
    result = false
    if block_given?
      my_each { |val| return true if yield(val) }
    end
    if argue
      my_each { |val| return true if argue === val } # rubocop:disable Style/CaseEquality
    else
      my_each { |val| return true unless val }
    end
    result
  end

  # my_none Enumberable method
  def my_none?(argu = nil)
    result = true
    if block_given?
      my_each { |val| return false if yield(val) }
    end
    if argu
      my_each { |val| return false if argu === val } # rubocop:disable Style/CaseEquality
    else
      my_each { |val| return false if val == true }
    end
    result
  end

  # my_count Enumberable method
  def my_count(para = nil)
    counter = 0
    if block_given?
      my_each { |val| counter += 1 if yield(val) }
    end
    if para
      my_each { |val| counter += 1 if para == val }
    else
      counter = length
    end
    counter
  end

  # my_count map method
  def my_map(proc = nil)
    return enum_for unless block_given?

    array = []

    if proc
      my_each { |element| array << proc.call(element) }
    else
      my_each { |element| array << yield(element) }
    end

    array
  end
end

# ...1...
puts '1.-------my_each-------'
p(1..5).my_each { |num| puts "the number is #{num}" }
p(%w[Sharon Leo Leila Brian Arun].my_each { |friend| puts "Hello, #{friend}" })
puts ''

# ..2...
puts '2.-------my_each_with_index-------'
p(%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts friend if index.even? })
p(%w[Sharon Leo Leila Brian Arun].my_each_with_index { |friend, index| puts "#{friend} is index #{index}" })
puts ''

# ..3...
puts '3.-------my_select-------'
p(%w[Sharon Leo Leila Brian Arun].my_select { |friend| friend != 'Brian' })
puts ''

# ..4...
puts '4.-------my_all-------'
puts(%w[ant bear cat].my_all? { |word| word.length >= 3 }) #=> true
puts(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
puts %w[ant bear cat].my_all?(/t/) #=> false
puts [1, 2i, 3.14].my_all?(Numeric) #=> true
puts [].my_all? #=> true
puts ''

# ..5...
puts(%w[ant bear cat].my_any? { |word| word.length >= 3 }) #=> true
puts(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
puts %w[ant bear cat].my_any?(/d/) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false
puts ''

# ..6...
p(%w[ant bear cat].my_none? { |word| word.length == 5 }) #=> true
p(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
p %w[ant bear cat].my_none?(/d/) #=> true
p [1, 3.14, 42].my_none?(Float) #=> false
p [].my_none? #=> true
p [nil].my_none? #=> true
p [nil, false].my_none? #=> true
p [nil, false, true].my_none? #=> false
puts ''

# ..7...
puts [1, 2, 4, 2].my_count #=> 4
puts [1, 2, 4, 2].my_count(2) #=> 2
puts([0, 1, 2, 3].count { |element| element > 1 }) # => 2
puts ''

# ..8...
puts '8.--------my_maps--------'
my_books = ['The Lord of the Rings', 'The Chronicles of Narnia', 'The Problem of Pain']
puts(my_books.my_map { |item| item.gsub('The', 'A') })
puts((0..5).my_map { |i| i * i })
puts 'my_map_proc'
my_proc = proc { |i| i * i }
puts(1..5).my_map(my_proc) { |i| i + i }
puts ''
