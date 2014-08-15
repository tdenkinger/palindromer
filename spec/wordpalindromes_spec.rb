require_relative "../lib/wordpalindromes"

describe WordPalindromes do
  let(:wp){ WordPalindromes.new "spec/data/test_dictionary.txt"}

  it "reads the local dictionary" do
    expect(wp.words).to_not be_empty
  end

  it "creates a segrated hash of reversed words" do
    expect(wp.lookup.keys.count).to eq 26
    expect(wp.lookup.fetch("s", [])).to_not be_empty
  end

  it "finds pair palindromes in the dictionary" do
    wp.find_all_palindromes
    expect(wp.palindromes).to_not be_empty
  end
end
