class Playlist < ActiveRecord::Base
  validates_presence_of :title
end
