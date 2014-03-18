require 'spec_helper'

describe Artist do
  it { should have_many(:albums) }
  it { should have_many(:songs) }
end
