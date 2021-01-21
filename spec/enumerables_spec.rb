require_relative '../enumerables'

describe Enumerable do
  let(:new_array) { [1, 2, 3] }
  let(:hash) { { one: 1, two: 2, three: 3 } }
  let(:range) { (1..3) }
  let(:my_books) { ['The Lord of the Rings', 'The Chronicles of Narnia', 'The Problem of Pain'] }

  describe '#my_each' do
    it 'returns each value in the array' do
      expect(new_array.my_each { |value| value }).to eql(new_array)
    end

    it 'returns the values in the hash' do
      expect(hash.my_each { |key, _val| key }).to eql(hash)
    end

    it 'returns the values in the range' do
      expect(range.my_each { |number| number }).to eql(range)
    end

    it 'returns false if the value is incorrect' do
      expect(new_array.my_each { |value| value }).to_not eql([1, 2, 1])
    end
  end

  describe '#my_each_with_index' do
    it 'return each value with index in the array' do
      expect(new_array.my_each_with_index { |value, _index| value }).to eql(new_array)
    end

    it 'returns the values in the hash' do
      expect(hash.my_each_with_index { |key, _val| key }).to eql(hash)
    end

    it 'returns the values in the range' do
      expect(range.my_each_with_index { |number| number }).to eql(range)
    end

    it 'return false if the value with index is incorrect' do
      expect(new_array.my_each_with_index { |value, _index| value }).to_not eql([1, 2, 1])
    end
  end

  describe '#my_select' do
    it 'return the true value' do
      expect(new_array.my_select { |num| num == 2 }).to eql([2])
    end

    it 'returns the values in the range' do
      expect(range.my_select { |number| number == 2 }).to eql([2])
    end

    it 'return false is the condition is not true' do
      expect(new_array.my_select { |num| num == 2 }).to_not eql([3])
    end
  end

  describe '#my_all?' do
    it 'returns true if all values are true' do
      expect(new_array.my_all?).to be_truthy
    end

    it 'retuns false if any value is false' do
      expect([nil, false, true].my_all?).to be_falsy
    end

    it 'returns true if all elements are numeric values' do
      expect(new_array.my_all?(Numeric)).to be_truthy
    end

    it 'returns true if elements contain the given regular expression' do
      expect(%w[ant bat cat].my_all?(/t/)).to be_truthy
    end
  end

  describe '#my_any?' do
    it 'returns true if any value is true' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to be_truthy
    end

    it 'returns false if any value is false' do
      expect(%w[ant bear cat].my_any?(/d/)).to be_falsy
    end

    it 'returns true if any value is integer' do
      expect([nil, true, 99].my_any?(Integer)).to be_truthy
    end

    it 'returns true if any value is integer' do
      expect([nil, true, 99].my_any?).to be_truthy
    end
  end

  describe '#my_none?' do
    it 'returns true if the condition is flase' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to be_truthy
    end

    it 'returns false if the condition is true' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 4 }).to be_falsy
    end

    it 'returns true if Regular expression is false' do
      expect(%w[ant bear cat].my_none?(/d/)).to be_truthy
    end

    it 'returns false if none of the values in array are floats' do
      expect([1, 3.14, 42].my_none?(Float)).to be_falsy
    end

    it 'returns false if any value is true' do
      expect([nil, false, true].my_none?).to be_falsy
    end
  end

  describe '#my_count' do
    it 'returns the total number of values in the array' do
      expect([1, 2, 4, 2].my_count).to eql(4)
    end

    it 'returns the total number of repeated values in the array' do
      expect([1, 2, 4, 2].my_count(2)).to eql(2)
    end

    it 'returns the numbers greater then given value in the array' do
      expect([0, 1, 2, 3].my_count { |element| element > 1 }).to eql(2)
    end

    it 'returns the numbers greater then given value in the range' do
      expect(range.my_count { |element| element > 1 }).to eql(2)
    end
  end

  describe '#my_map' do
    it 'returns the new array with replaced values' do
      expect(my_books.my_map do |item|
               item.gsub('The', 'A')
             end).to eql(['A Lord of the Rings', 'A Chronicles of Narnia', 'A Problem of Pain'])
    end

    it 'multiplies all the numbers in range' do
      expect((0..5).my_map { |i| i * i }).to eql([0, 1, 4, 9, 16, 25])
    end

    it 'returns true in new array if the values is greater then 20' do
      my_proc = proc { |num| num < 10 }
      expect([21, 22].my_map(my_proc) { |num| num > 20 }).to be_truthy
    end
  end

  describe '#my_inject' do
    it 'returns sum of total numbers in range' do
      expect((1..5).my_inject { |sum, n| sum + n }).to eql(15)
    end

    it 'return total by multiplying every value in range to its pevious value' do
      expect((1..5).my_inject(1) { |product, n| product * n }).to eql(120)
    end

    it 'return sum based on the arithmatic symbol provided as a argument' do
      expect((1..5).my_inject(1, :+)).to eql(16)
    end

    it 'return multiplied value based on the arithmatic symbol provided as a argument' do
      expect((1..5).my_inject(1, :*)).to eql(120)
    end

    it 'returns the longest number in string' do
      expect(%w[cardiology anatomy neurology].my_inject do |memo, word|
               memo.length > word.length ? memo : word
             end).to eql('cardiology')
    end
  end
end
