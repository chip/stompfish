class Artist < ActiveRecord::Base
  # associations
  has_many :albums, dependent: :destroy
  has_many :songs

  # validations
  validates :name, presence: true, uniqueness: true

  def self.names
    all.map(&:name).sort
  end

  def albums_by_date
    albums.sort_by(&:year)
  end
end
