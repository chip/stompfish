require 'spec_helper'

describe PlaylistCollaborator do
  it { should belong_to(:playlist) }
  it { should belong_to(:song) }

  it { should validate_presence_of(:position) }
  it { should validate_presence_of(:song_id) }
  it { should validate_presence_of(:playlist_id) }
  it { should validate_uniqueness_of(:position).scoped_to(:playlist_id) }
end
