class Artist < ActiveRecord::Base
  has_many :albums
  has_many :songs

  validates :name, presence: true, uniqueness: true
end
