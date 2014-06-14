require 'spec_helper'

describe ArtistsController do
  let(:artist) { Artist.create(name: "Some Artist") }
  let!(:serialized) { ArtistSerializer.new(artist).serializable_hash }

  describe "GET #index" do
    before { get :index }

    it "renders @artists as json" do
      get :index
      expect(response.body).to eq("{\"artists\":[#{serialized.to_json}]}")
    end

    it "has a 200 http status" do
      expect(response.code).to eq("200")
    end
  end

  describe "GET #show" do
    before { get :show, id: artist }

    it "has a 200 http status" do
      expect(response.code).to eq("200")
    end

    it "renders @artist as json" do
      expect(response.body).to eq("{\"artist\":#{serialized.to_json}}")
    end

    context "artist not found" do
      it "has a 404 status" do
        get :show, id: :foo
        expect(response.code).to eq("404")
      end

      it "has a message" do
        get :show, id: :foo
        expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
      end
    end
  end
end
