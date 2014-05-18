require 'spec_helper'

describe ApplicationController do
  controller(PlaylistSongsController) {}

  it "redirects to errors#routing for ActionController::RoutingError" do
    get :create
    expect(response.body).to eq("{\"message\":\"Resource Not Found.\"}")
  end
end
