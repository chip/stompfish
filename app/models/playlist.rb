class Playlist < ActiveRecord::Base
  include Elasticsearch::Model

  # validations
  validates_presence_of :title
end
