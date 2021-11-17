require "rspec"
require_relative "../app/methods"

#russian-like_strings_generator_spec
describe "rl_str_gen" do 

  it "It should return string" do
    1000.times do
      expect(rl_str_gen).to be_an_instance_of(String)
    end
  end


  it "It should contain only valid symbols" do
    1000.times do
      expect(rl_str_gen.match? /[^а-яё ,\.:;\-!\?\"\']/i).to be false
    end
  end


  it "It should not be ower 300 symbols" do 
    100000.times do
      expect(rl_str_gen.size).to be <= 300
    end
  end


  it "It should contain from 2 to 15 words" do 
    1000.times do
      str = rl_str_gen
      expect(str.size).to be <= 300
      expect(str.gsub("- ", "").match? /\A(?:[^ ]+ ){1,14}[^ ]+\z/).to be(true)
    end
  end


  it "It should not contains wors over 15 letters" do
    1000.times do
      words = rl_str_gen.scan(/[а-яё]+(?:-[а-яё]+)?/i)
      expect(words.count{|el| el.size > 15}).to eq(0)
    end
  end


  it "If should allow only particular signs after words with it sentence" do
    1000.times do
      with_in = rl_str_gen.split.reject{|el| el == "-"}[0..-2]
      expect(with_in.select{|el| el[-1].match? /[^,:\"\'а-яё]/}.size).to eq(0)
    end
  end


  it "If should allow only particular signs in the end of the sentence" do

    1000.times do
      expect(rl_str_gen.match? /.*[а-яё]+[\"\']?(\.|!|\?|!\?|\.\.\.)\z/)
                       .to be true
    end
  end

  # it "It should not allow multiple punctuation marcs" do 

  # end


  it "If should not allow unwanted symbols inside words" do

    1000.times do
      expect(rl_str_gen.match? /[а-яё\-][^а-яё \-]+[а-яё\-]/).to be false
    end
      # words = rl_str_gen.split.reject{|el| el=="-"}
    end
    # /\A[\"\']?[а-яё]+(?:-[а-яё]+)?[\"\']?\z/i
  end


  # it "It should not allow multiple dashes" do #
