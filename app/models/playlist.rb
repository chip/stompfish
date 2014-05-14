class Playlist < ActiveRecord::Base
  include Elasticsearch::Model

  # associations
  has_many :playlist_collaborators
  has_many :songs, through: :playlist_collaborators

  # validations
  validates_presence_of :title
end
