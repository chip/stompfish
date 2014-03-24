require 'spec_helper'

describe ArtistsController do
  let(:artist) { Artist.create!(name: "Some Artist") }

  describe "GET #index" do
    before { get :index }

    it "assigns Artist.all to @artist" do
      expect(assigns(:artists)).to eq(Artist.all)
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: artist }

    it "assigns the requested artist to @artist" do
      expect(assigns(:artist)).to eq(artist)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end
end
