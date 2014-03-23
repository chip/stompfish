require 'spec_helper'

describe PlaylistsSong do
  it { should belong_to(:playlist) }
  it { should belong_to(:song) }
end
