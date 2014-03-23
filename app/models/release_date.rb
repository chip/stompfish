class ReleaseDate < ActiveRecord::Base
  # associations
  has_many :albums

  # validations
  validates :year, presence: true, uniqueness: true
end
