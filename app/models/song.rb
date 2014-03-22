class Song < ActiveRecord::Base
  delegate :bit_rate, :duration, :filename, :filesize,
    :format, :mtime, :duration_to_human, :filesize_to_human,
    to: :song_file

  delegate :name, to: :artist, prefix: true
  delegate :title, :image, to: :album, prefix: true
  delegate :date, :genre, to: :album

  belongs_to :album
  belongs_to :artist
  has_one :song_file, as: :fileable

  validates_presence_of :album_id, :artist_id, :title
  validates_uniqueness_of :title, scope: [:album_id, :track]
end
