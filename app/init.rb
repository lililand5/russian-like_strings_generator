require_relative "methods"

def rl_str_gen #russian like strings generator
  words_gen(plan_words).map{|a| a << 32}.flatten[0..-2].pack("U*")
end

p rl_str_gen
