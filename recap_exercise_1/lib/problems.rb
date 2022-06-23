# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
    pairs = []
    words.each_with_index do |word_1, i|
        words.each_with_index do |word_2, j|
            if i < j
                if has_all_vowels(word_1, word_2)
                    pairs << word_1 + " " + word_2
                end
            end
        end
    end

    return pairs
end

def has_all_vowels(word_1, word_2)
    count = {'a' => 0, 'e' => 0, 'i' => 0, 'o' => 0, 'u' => 0}
    vowels = "aeiou"
    vowels.each_char { |vowel| count[vowel] }

    combined_word = word_1 + word_2
    combined_word.chars.each do |char|
        if vowels.include?(char)
            count[char] += 1
        end
    end

    return count.values.all? { |v| v >= 1 }
end

# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return true
        end
    end
    return false
end

# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    found = []
    bigrams.each do |bigram|
        if str.index(bigram) != nil
            found << bigram
        end
    end
    return found
end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        prc ||= Proc.new { |k, v| k == v}
        self.select { |k, v| prc.call(k, v) }
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        substrs = []
        end_idx = 0
        if length == nil
            self.each_char.with_index do |_, start_idx|
                end_idx = start_idx
                while end_idx < self.length
                    substrs << self[start_idx..end_idx]
                    end_idx += 1
                end
            end
        else
            start_idx = 0
            while start_idx + (length - 1) < self.length
                substrs << self[start_idx..start_idx + (length - 1)]
                start_idx += 1
            end
        end
        return substrs
    end

    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        alphabet = ('a'..'z').to_a
        new_str = self.chars.map { |c| alphabet[(alphabet.index(c) + num) % 26]}
        new_str.join("") 
    end
end
