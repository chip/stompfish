require 'spec_helper'

describe Album do
  it { should belong_to(:artist) }
  it { should have_many(:songs) }
end