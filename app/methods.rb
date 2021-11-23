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
    word = [1072, 1103, 1074, 1086, 1091, 1080, 1082, 1089].sample
  else
    word = generate_single_syllable_word
  end

  word = add_dash(word) if hash[:dash]

  word
  # :one_letter
  # :dashe
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

