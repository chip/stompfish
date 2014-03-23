require 'spec_helper'

describe Album do
  context "associations" do
    it { should belong_to(:artist) }
    it { should belong_to(:genre) }
    it { should belong_to(:release_date) }
    it { should have_many(:songs) }
  end

  context "validations" do
    it { should validate_presence_of(:artist_id) }
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title).scoped_to(:artist_id) }
  end
end
