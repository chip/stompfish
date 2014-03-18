class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  has_many :song_files, as: :fileable
end
