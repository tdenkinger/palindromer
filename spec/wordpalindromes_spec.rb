require_relative "../lib/wordpalindromes"

#12331 pairs?

describe WordPalindromes do
  let(:wp){ WordPalindromes.new "spec/data/test_dictionary.txt"}

  it "finds expected palindromes in the dictionary" do
    wp = WordPalindromes.new "../Words/Words/en.txt"
    wp.find_all_palindromes
    expect(wp.palindromes).to include ["lived","evil"]
  end
end
