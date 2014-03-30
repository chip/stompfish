require 'elasticsearch/model'

class Song < ActiveRecord::Base
  include Elasticsearch::Model

  # associations
  belongs_to :album
  belongs_to :artist

  has_one :song_file, as: :fileable, dependent: :destroy

  has_many :playlist_collaborators
  has_many :playlists, through: :playlist_collaborators

  # validations
  validates_presence_of :album_id, :artist_id, :title
  validates_uniqueness_of :title, scope: [:album_id, :track]

  # delegations
  delegate :bit_rate, :duration, :filename, :filesize,
    :format, :mtime, :duration_to_human, :filesize_to_human,
    to: :song_file

  delegate :date, :genre, to: :album
  delegate :name, to: :artist, prefix: true
  delegate :position, to: :playlists
  delegate :title, :image, to: :album, prefix: true

  # scopes
  scope :duration_less_than, ->(time) do
    SongScopes::DurationScope.new(high: time).less_than
  end

  scope :duration_greater_than, ->(time) do
    SongScopes::DurationScope.new(low: time).greater_than
  end

  scope :duration_between, ->(low, high) do
    SongScopes::DurationScope.new(high: high, low: low).between
  end
end
