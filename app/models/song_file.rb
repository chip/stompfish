class SongFile < ActiveRecord::Base
  belongs_to(:song)
end
