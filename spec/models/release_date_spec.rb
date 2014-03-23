require 'spec_helper'

describe ReleaseDate do
  context "#validations" do
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:year) }
  end
end
