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
    @words.each{| word | test_against_lookup word }
  end

  private

  def pad_letters array, position = :end
    array.push('')    if array.length < 3 && position == :end
    array.unshift('') if array.length < 3 && position == :start
    array
  end

  def test_against_lookup word
    letters = pad_letters(word[0..2].chars, :end)

    @lookup[letters[0]][letters[1]][letters[2]].each do | lookup_word |
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
      add_word_to_lookup word
    end
  end

  def add_word_to_lookup word
    letters = pad_letters(word.chars, :start)
    @lookup[letters[-1]][letters[-2]][letters[-3]] << word
  end

  def initialize_lookup_index
    ('a'..'z').to_a.reduce({}) do | hash, letter |
      hash[letter] = generate_hash
      ('a'..'z').to_a.reduce({}) do | inner_hash, inner_letter |
        hash[letter][inner_letter] = generate_hash
      end

      hash
    end
  end

  def generate_hash
    ('a'..'z').to_a.reduce({}) do | hash, letter |
      hash[letter] = []
      hash[""] = []
      hash
    end
  end
end
