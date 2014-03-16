require '../lib/task1.rb'

describe 'Injector' do 
	let(:numbers) {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]}
	
	it 'testing injection without an initial value with an initial value of zero' do
		expect(numbers.injector(0) {|num, val| num + val }).to eq(55)
	end

	it 'testing injection without an initial value' do
    expect(numbers.injector {|num, val| num + val }).to eq(55)
  end 

  it 'testing injection without an initial value given as an argument' do
    expect(numbers.injector(3) {|num, val| num + val }).to eq(58)
  end 
 
	 it 'should only display even numbers' do
	 	even = Array.new
	 	expect(numbers.injector {|num, val|  even << num.to_s if num % 2 == 0})
	 end

  it 'should concatenate words(strings)' do
  	words = ['It', 'is', 'fun', 'coding', 'in', 'Ruby', '.']
  	expect(words.injector {|sentence, word| sentence << word.capitalize << " "})
  end
end