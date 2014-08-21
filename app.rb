#!/usr/bin/env ruby

require "./lib/wordpalindromes"

wp = WordPalindromes.new ARGV[0] || abort("Please pass in the path to a word list")
wp.find_all_palindromes

puts "Found #{wp.palindromes.count} palindrome pairs"

