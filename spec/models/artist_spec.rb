require 'spec_helper'

describe Artist do
  it { should have_many(:albums) }
  it { should have_many(:songs) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
