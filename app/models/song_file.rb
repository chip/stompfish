class SongFile < ActiveRecord::Base
  # associations
  belongs_to :fileable, polymorphic: true

  # validations
  validates_presence_of :fileable_id, :fileable_type, :filename
  validates_uniqueness_of :filename

  def duration_to_human
    Formatters::Duration.as_strftime(duration)
  end

  def filesize_to_human
    Formatters::Filesize.to_human_size(filesize)
  end
end
