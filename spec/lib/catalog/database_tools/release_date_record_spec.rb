require 'spec_helper'

describe Catalog::DatabaseTools::ReleaseDateRecord do
  subject { Catalog::DatabaseTools::ReleaseDateRecord }

  let(:release_date_model) { Class.new} 

  before do
    stub_const("ReleaseDateModel", release_date_model)
  end

  context ".add" do
    it "adds new ReleaseDate" do
      expect(release_date_model).
        to receive(:find_or_create_by).
        with(year: 1977)

      subject.add(year: 1977,
                            release_date_model: release_date_model)
    end

    it "returns nil if no year" do
      release_date = subject.
        add(year: nil, release_date_model: release_date_model)

      expect(release_date).to be_nil
    end
  end

  context "#release_date_model" do
    it "defaults release_date model to ReleaseDate" do
      creator = subject.new(year: 1977)
      expect(creator.release_date_model).to eq(ReleaseDate)
    end
  end
end
