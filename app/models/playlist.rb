class Playlist < ActiveRecord::Base
  # associations
  has_many :playlist_collaborators
  has_many :songs, through: :playlist_collaborators

  # validations
  validates_presence_of :title
end
