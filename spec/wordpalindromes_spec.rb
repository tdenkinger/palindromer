require_relative "../lib/wordpalindromes"

describe WordPalindromes do
  let(:wp){ WordPalindromes.new "spec/data/test_dictionary.txt"}

  it "finds expected palindromes in the dictionary" do
    wp.find_all_palindromes
    expect(wp.palindromes).to include ["lived","evil"]
  end
end
