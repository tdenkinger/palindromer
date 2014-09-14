require "set"

class WordPalindromes
  attr_reader :words, :lookup, :palindromes

  def initialize dictionary="/usr/share/dict/words"
    @words = Set.new
    @lookup = initialize_lookup_index
    @palindromes = []
    read_dictionary dictionary
  end

  def find_all_palindromes
    @words.each do | word |
      test_against_lookup word[0..1], word
    end
  end

  private

  def test_against_lookup indexes, word
    @lookup[indexes[0]][indexes[1]].each do | lookup_word |
      next if lookup_word == word
      next unless lookup_word.include?(word.reverse) || word.include?(lookup_word.reverse)
      test_for_palindrome word, lookup_word
    end
  end

  def test_for_palindrome word, lookup_word
    if palindrome? [word, lookup_word]
      @palindromes << [word, lookup_word]
    end
  end

  def palindrome? words
    string_to_test = words.join.gsub(/\s+/, "")
    string_to_test == string_to_test.reverse
  end

  def read_dictionary dictionary
    File.open(dictionary).each do | word |
      word = word.downcase.chomp
      @words.add word
      @lookup[word[-1]][word[-2]] << word
    end
  end

  def initialize_lookup_index
    ('a'..'z').to_a.reduce({}) do | hash, letter |
      hash[letter] = generate_hash
      hash
    end
  end

  def generate_hash
    ('a'..'z').to_a.reduce({}) do | hash, letter |
      hash[letter] = []
      hash
    end
  end
end
