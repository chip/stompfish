class Playlist < ActiveRecord::Base
  has_and_belongs_to_many :songs
  validates_presence_of :title
end
