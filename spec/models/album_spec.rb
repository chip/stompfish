require 'spec_helper'

describe Album do
  it { should belong_to(:artist) }
  it { should have_many(:songs) }

  it { should validate_presence_of(:artist_id) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).scoped_to(:artist_id) }
end
