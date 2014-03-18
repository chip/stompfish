require 'spec_helper'

describe SongFile do
  it { should belong_to(:song) }
end
