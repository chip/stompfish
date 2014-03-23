require 'spec_helper'

describe PlaylistsSong do
  it { should belong_to(:playlist) }
  it { should belong_to(:song) }

  it { should validate_presence_of(:position) }
end
