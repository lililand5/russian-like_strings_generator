# Частота букв алфавита
LETTERS_FREQ = {
  1072 => 801, # а
  1073 => 159, # б
  1074 => 454, # в
  1075 => 170, # г
  1076 => 298, # д
  1077 => 749, # е
  1105 => 100, # ё
  1078 => 94, # ж
  1079 => 165, # з
  1080 => 735, # и
  1081 => 121, # й
  1082 => 349, # к
  1083 => 440, # л
  1084 => 321, # м
  1085 => 670, # н
  1086 => 1097, # о
  1087 => 281, # п
  1088 => 473, # р
  1089 => 547, # с
  1090 => 626, # т
  1091 => 262, # у
  1092 => 26, # ф
  1093 => 97, # х
  1094 => 48, # ц
  1095 => 144, # ч
  1096 => 73, # ш
  1097 => 36, # щ
  1098 => 4, # ъ
  1099 => 190, # ы  
  1100 => 174, # ь
  1101 => 32, # э
  1102 => 64, # ю
  1103 => 201 # я
}.freeze


# удельный вес букв "ивясакуо"
ONE_LETTER_WORDS_FREQ = {
  1080 => 358, # и
  1074 => 314, # в
  1103 => 127, # я
  1089 => 113, # с
  1072 => 82, # а
  1082 => 54, # к
  1091 => 43, # у
  1086 => 34 # о
}.freeze



# вероятностный массив для однобуквенных слов
# предоставь распределенный однобуквенный массив
def provide_distribution(hash)
  sample_array = []
  hash.each_key do |k|

    hash[k].times do 
      sample_array << k
    end
    sample_array.freeze
    sample_array
  end
end

ONE_LETTER_WORDS_PROBABILITY_ARRAY = provide_distribution(ONE_LETTER_WORDS_FREQ)


LETTERS_PROBABILITY_ARRAY          = provide_distribution(LETTERS_FREQ)








# методы

def rl_str_gen #russian like strings generator
  base_string
end


def base_string

  x = [*1040..1103, 1105, 1025]
  arr = Array.new(rand(3..250)) { x.sample }
  index = rand(1..15)

  while index < arr.size do
    arr[index] = 32
    index += rand(2..16)
  end

  # p arr.pack("U*")
  arr.pack("U*")
end


# p base_string

def format_case(str)
  str.split
end


def plan_words
  arr = Array.new(rand(2..15)) {{}}
  
    # arr[el] = {
    #   case: :downcase,
    #   multi_syllable: true,
    #   dash: true,
    #   one_letter: false
    #   }
    arr.each do |el|
      case rand(10)
      when 0
        el[:case] = :accronym
      when 1
        el[:case] = :capital
      else 
        el[:case] = :downcase
      end


      if el[:case] != :accronym
        el[:multi_syllable] = rand(5) == 0 ? false : true    
      end


      if el[:multi_syllable] == true  
        el[:dash] = rand(20) == 0 ? true : false

      elsif el[:multi_syllable] == false

        if el[:one_letter] = rand(2) == 0  
          el[:one_letter] = true && el[:case] = :downcase
        else 
          el[:one_letter] = false
        end
      end
    end
  end


# массив с отдельными словами
def words_gen(arr)

  arr.map do |el|
    case el[:case]
    when :accronym
      make_accronym
    when :downcase
      make_common_word(el)     # make_common_word(el)
    when :capital
      digital_capitalize(make_common_word(el))
    end
  end
end


def make_accronym
  letters = [*1040..1048, *1050..1065, *1069..1071, 1025]
  Array.new(rand(2..5)) { letters.sample }
end


# Правила:
# не должно начинаться с ь ъ ы 
# В начале слова всегда должна стоять гласная "е" или "о" после 'й'
# Он должен разрешать только определенные буквы после "й" внутри слов
# В двухбуквенном и трехбуквенном слове должна быть гласная
# Он должен разрешать только определенные однобуквенные слова
# Он не должен допускать более 4-х согласных букв подряд
# Он не должен допускать больше чем 2 гласные буквы подряд
# Он не должен допускать более двух одинаковых согласных букв подряд
# Он должен содержать не менее 40% гласных в многосложных словах.
# Должен содержать 5 и менее согласных в односложных словах
# Он должен разрешать только "я е ё ю" после "ъ ь" 
# В односложных словах не должно быть гласных в начале слова, 
# если они состоят из 3 или более букв.



def make_common_word(hash) 

  # :case
  if hash[:multi_syllable]
    word = generate_multi_syllable
  elsif hash[:one_letter]
    ONE_LETTER_WORDS_PROBABILITY_ARRAY.sample

  else
    word = generate_single_syllable_word
  end

  word = add_dash(word) if hash[:dash]

  word
  # :one_letter
  # :dashe
end


def generate_single_syllable_word

  length = rand(20) < 15 ? rand(2..4) : rand(5..7)
  vowel = [1072, 1086, 1091, 1101, 1099, 1080, 1103, 1077, 1105, 1102].sample


  [1073, 1074, 1075, 1076, 1078, 1079, 1082, 1083, 1084, 1085, 1087, 1088, 1089, 1090, 1092, 1093, 1094, 1095, 1096, 1097]
  
end



def digital_capitalize(arr)
  if arr[0] == 1105
    arr[0] = 1025
  elsif arr[0] > 1071
    arr[0] -= 32
  end
  arr
end

# абревиатуры, односложные, многосложные, составные, однобуквенные, большая буква в начале строки

