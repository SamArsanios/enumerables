require_relative '../enumerables.rb'

describe Enumerable do
    let(:new_array) { [1, 2, 3]}
    describe '#my_each' do
        it 'returns each value in the array' do
            expect(new_array.my_each { | value | value }).to eql(new_array)
        end

        it 'returns false if the value is incorrect' do
            expect(new_array.my_each { | value | value }).to_not eql([1, 2, 1])
        end
    end

    describe '#my_each_with_index' do
        it 'return each value with index in the array' do
            expect(new_array.my_each_with_index { | value, index | value}).to eql(new_array)
        end

        it 'return false if the value with index is incorrect' do
            expect(new_array.my_each_with_index { | value, index | value}).to_not eql([1, 2, 1])
        end
    end

    describe '#my_select' do
        it 'return the true value' do
            expect(new_array.my_select { |num| num == 2}).to eql([2])
        end

        it 'return false is the condition is not true' do
            expect(new_array.my_select { |num| num == 2}).to_not eql([3])
        end
    end
end