require_relative '../enumerables'

describe Enumerable do
  let(:new_array) { [1, 2, 3] }
  let(:hash) { { one: 1, two: 2, three: 3 } }
  let(:range) { (1..3) }

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
    it 'returns if any value is true' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to be_truthy
    end

    it 'returns if any value is false' do
      expect(%w[ant bear cat].my_any?(/d/)).to be_falsy
    end

    it 'returns true if any value is integer' do
      expect([nil, true, 99].my_any?(Integer)).to be_truthy
    end

    it 'returns true if any value is integer' do
      expect([nil, true, 99].my_any?).to be_truthy
    end
  end
end
