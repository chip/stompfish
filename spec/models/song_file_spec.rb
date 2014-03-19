require 'spec_helper'

describe SongFile do
  it { should belong_to(:fileable) }

  it { should validate_presence_of(:filename) }
  it { should validate_presence_of(:fileable_id) }
  it { should validate_presence_of(:fileable_type) }
  it { should validate_uniqueness_of(:filename) }
end
