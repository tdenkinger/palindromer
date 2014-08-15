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
    @words.each{ | word | test_against_dictionary word }
  end

  private

  def dictionary_word? word
    @words.include? word
  end

  def test_against_dictionary word
    return unless dictionary_word? word.reverse
    test_against_index @lookup[word[-1]], word
  end

  def test_against_index index, word
    index.each do | lookup_word |
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
      next if word.length == 2
      word = word.downcase.chomp

      @words.add word
      @lookup[word[-1]] << word.reverse
    end
  end

  def initialize_lookup_index
    ('a'..'z').to_a.reduce({}) do | hash, letter |
      hash[letter] = []
      hash
    end
  end
end
