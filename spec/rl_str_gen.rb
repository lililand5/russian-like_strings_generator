require "rspec"
require_relative "../app/methods"

#russian-like_strings_generator_spec
describe "rl_str_gen" do 

    it "It should contain from 2 to 15 words" do 
      
      1000.times do
      str = rl_str_gen
      expect(str.scan(/[а-яё]/i).size).to be >= 2
      expect(str.scan(/[а-яё]/i).size).to be <= 15
    end

    it "It should not contains wors over 15 letters"

      1000.times do
        str = rl_str_gen
        expect(str.scan(/[а-яё]/i).count{|el| le.size > 15}).to eq(0)
      end
  end
end