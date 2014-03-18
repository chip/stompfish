class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  has_many :song_files, as: :fileable

  validates_presence_of :album_id, :artist_id, :title
end
