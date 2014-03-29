require 'character_encoding/replace_invalid_characters'

describe CharacterEncoding::ReplaceInvalidCharacters do
  subject { CharacterEncoding::ReplaceInvalidCharacters }

  it "replaces bad encoding" do
    string = "bad\xE9encoding"
    fixed = subject.clean(string)
    expect(fixed).to eq("badencoding")
  end

  it "does not replace safe encoding" do
    string = "good encoding"
    fixed = subject.clean(string)
    expect(fixed).to eq("good encoding")
  end

  it "has valid_encoding if it is valid" do
    string = subject.new("foo")
    expect(string).to have_valid_encoding
  end

  it "converts value to string" do
    string = 1
    fixed = subject.clean(string)
    expect(fixed).to eq("1")
  end
end
