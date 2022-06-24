def no_dupes?(arr)
    count = arr.tally
    no_dupes = count.select { |k, v| v == 1 }.keys
end

# Examples
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    i = 0
    while i < arr.length - 1
        if arr[i] == arr[i + 1]
            return false
        end
        i += 1
    end
    return true
end

# Examples
# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    indices = Hash.new{ |h, k| h[k] = Array.new }
    str.each_char.with_index { |c, i| indices[c] << i }
    indices
end

# Examples
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    streaks = []
    max_streak = 0
    streak = 0
    
    i = 0
    while i < str.length
        current_char = str[i]
        current_streak = ""
        
        while str[i] == current_char
            current_streak << str[i]
            streak += 1
            i += 1
        end

        if streak >= max_streak
            max_streak = streak
            streaks << current_streak
        end
        streak = 0
    end

    return streaks.last
end

# Examples
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    return true
end

def get_primes(num)
    (2..num).select { |n| prime?(n)}
end

def bi_prime?(num)
    primes = get_primes(num)

    primes.each_with_index do |p_1, i|
        primes.each_with_index do |p_2, j| 
            if p_2 * p_2 == num
                return true
            end
            if i < j
                if p_1 * p_2 == num
                    return true
                end
            end
        end
    end

    return false
end

# Examples
# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    alphabet = ('a'..'z').to_a
    new_msg = ""
    key_i = 0
    i = 0
    while i < message.length
        # the extra condition of "i < message.length" was needed to get rid of extra letter in
        # the fourth test example 'vigenere_cipher("zebra", [3, 0])'
        while key_i < keys.length && i < message.length
            new_position = alphabet.index(message[i]).to_i + keys[key_i]
            new_msg << alphabet[new_position % 26]
            i += 1
            key_i += 1
        end
        key_i = 0
    end
    return new_msg
end

# Examples
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def find_vowels(str)
    str_vowels = []
    vowels = "aeiou"
    str.each_char do |c|
        if vowels.include?(c)
            str_vowels << c
        end
    end
    return str_vowels
end

def vowel_rotate(str)
    vowels = find_vowels(str)
    vowels = vowels.reverse

    new_str = "" 
    str.each_char do |c|
        if "aeiou".include?(c)
            new_str << vowels[0]
            # When Array#rotate is given a negative number, 
            # the last element moves to the front of the array
            vowels = vowels.rotate(-1)
        else
            new_str << c
        end
    end
    new_str
end

# Examples
# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&prc)
        if prc.nil?
            return self
        end

        new_str = ""
        self.each_char do |c|
            if prc.call(c)
                new_str << c
            end
        end
        new_str
    end

    def map!(&prc)
        self.each_char.with_index do |c, i|
            if prc.call(c, i)
                self[i] = prc.call(c, i)
            end
        end
        return self
    end
end

# Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

def multiply(a, b)
    # works when 'b' is positive
    if b == 0
        return 0
    end
    # for the case in which 'b' is negative
    if b < 0
        return -(a) + multiply(a, b + 1)
    end

    return a + multiply(a, b - 1)
end

# Examples
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(n)
    if n == 0
        return []
    elsif n == 1
        return [2]
    elsif n == 2
        return [2, 1]
    end

    seq = lucas_sequence(n - 1) 
    seq << seq[-1] + seq[-2]
    return seq
end

# Examples
# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def get_product(arr)
    arr.inject { |prod, el| prod * el }
end

def prime_factorization(num)
    (2...num).each do |fact|
        if (num % fact == 0)
            otherFact = num / fact
            return [ *prime_factorization(fact), *prime_factorization(otherFact) ]
        end
    end

    [num]
end

# Examples
p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]