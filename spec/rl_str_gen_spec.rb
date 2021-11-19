require "rspec"
require_relative "../app/methods"

#russian-like_strings_generator_spec
describe "rl_str_gen" do 

  # должен вернуть строку 
  it "It should return string" do
    1000.times do
      expect(rl_str_gen).to be_an_instance_of(String)
    end
  end

  # долны быть только допустимые символы
  it "It should contain only valid symbols" do
    1000.times do
      expect(rl_str_gen.match? /[^а-яё ,\.:;\-!\?\"]/i).to be false
    end
  end

  # не допускает более 300 символов
  it "It should not be ower 300 symbols" do 
    10000.times do
      expect(rl_str_gen.size).to be <= 300
    end
  end

  # от 2 до 15 слов
  it "It should contain from 2 to 15 words" do 
    1000.times do
      str = rl_str_gen
      expect(str.size).to be <= 300
      expect(str.gsub("- ", "").match? /\A *(?:[^ ]+ +){1,14}[^ ]+\z/)
      .to be(true)
    end
  end

  # не должен содержать более 15 букв
  it "It should not contains wors over 15 letters" do
    1000.times do
      words = rl_str_gen.scan(/[а-яё]+(?:-[а-яё]+)?/i)
      expect(words.count{|el| el.size > 15}).to eq(0)
    end
  end

  # откидываем последнее слово 
  # и в массиве строк берем только последний символ строки
  # запретили перед закрывающей кавычкой знаки препинания
  it "If should allow only particular marks after words within sentence" do
    1000.times do
      with_in = rl_str_gen.split.reject{|el| el == "-"}[0..-2]
      expect(with_in.reject{|el| el.match? /[а-яё]\"?[,:;]?\z/i}
        .size)
      .to eq(0)
    end
  end

  # только определенные знаки вконце предложения
  it "If should allow only particular signs in the end of the sentence" do
    1000.times do
      expect(rl_str_gen.match? /.*[а-яё]+\"?(\.|!|\?|!\?|\.\.\.)\z/)
      .to be true
    end
  end

  # не допускать нежелательные символы внутри слов 
  it "If should not allow unwanted symbols inside words" do
    1000.times do
      expect(rl_str_gen.match(/[а-яё\-][^а-яё \-]+[а-яё\-]/)).to be_nil
    end
  end

  # не должно позволять минусы (dashes) в начале слова 
  # как работает провера если ты внутри слова, ты нашел то что непотребство, 
  # но перед ним стоит буква, если надешь такой случай - игнорируй
  it "It should exclude unwanted symbols before word's" do
    1000.times do
      expect(rl_str_gen.match(/(?<![а-яё])[^ \"а-яё]+\b[а-яё]/i)).to be_nil
    end
  end

  #Не допускается использование нескольких знаков препинания. 
  it "It should not allow multiple punctuation marks" do 
    1000.times do
      expect(rl_str_gen.match(/([^а-яё\.]) *\1/i)).to be_nil
    end
  end

  # Правильное использование кавычек(четное число)
  it "It should correctly use quotation marks" do
    1000.times do 
      str = rl_str_gen
      expect( str.scan(/\"/).size.even? ).to be true
      expect( str.scan(/\".+?\"/)
        .reject { |el| el.match? /\"[а-яё].+[а-яё]\"/i }.size ).to eq(0)
    end
  end

  # не должно допускать слов, начинающихся с 'ь ъ ы 
  it "should not allow words starting with 'ь ъ ы'" do

  end

  # Не допускать заглавных букв после дефис и внутри слова если слово не аббревиатура
  it "It should not contain capital latters inside words if not an accronym" do

  end
  
  # В начале слова всегда должна стоять гласная после 'й'
  it "It should allways have vowel after 'й' at the beginning of the word" do 

  end

  # Он не должен допускать более 4-х согласных букв подряд
  it "It should not allow more than 4 consonant latters in a row" do 

  end

  # Он не должен допускать более 2-х гласных букв подряд
  it "It should not allow more than 2 vowel latters in a row" do 

  end

  # Он не должен допускать более двух одинаковых согласных букв подряд
  it "It should not allow more than 2 same consonant latters in a row" do 

  end

  # Он должен содержать гласные, если не более 1 буквы и не аббревиатура. 
  it "It should contains vowels if not more than 1 latter and not an accronym" do

  end

end


