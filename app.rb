#!/usr/bin/env ruby

require "./lib/wordpalindromes"

wp = WordPalindromes.new "../Words/Words/en.txt"
wp.find_all_palindromes

wp.palindromes.each do | palindrome_pair |
  puts palindrome_pair.join " "
end
