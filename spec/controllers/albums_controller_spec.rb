require 'spec_helper'

describe AlbumsController do
  before do
    artist = Artist.create!(name: "Some Artist")
    @album = Album.create!(title: "Some Album", artist: artist)
  end

  describe "GET #index" do
    before { get :index }

    it "assigns Album.all to @album" do
      expect(assigns(:albums)).to eq(Album.all)
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    before { get :show, id: @album }

    it "assigns the requested album to @album" do
      expect(assigns(:album)).to eq(@album)
    end

    it "renders the :show view" do
      expect(response).to render_template(:show)
    end
  end
end
