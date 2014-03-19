class SongFile < ActiveRecord::Base
  belongs_to :fileable, polymorphic: true

  validates_presence_of :fileable_id, :fileable_type, :filename
  validates_uniqueness_of :filename
end
