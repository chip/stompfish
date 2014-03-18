require 'spec_helper'

describe Song do
  it { should belong_to(:album) }
  it { should belong_to(:artist) }
  it { should have_many(:song_files) }
end
