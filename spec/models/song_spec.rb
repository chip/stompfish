require 'spec_helper'

describe Song do
  it { should belong_to(:album) }
  it { should belong_to(:artist) }
  it { should have_many(:song_files) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:artist_id) }
  it { should validate_presence_of(:album_id) }
  it { should validate_uniqueness_of(:title).scoped_to([:album_id, :track])}
end
