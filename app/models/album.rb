class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  validates_presence_of :artist_id, :title
  validates_uniqueness_of :title, scope: :artist_id
end
