class ReleaseDate < ActiveRecord::Base
  # validations
  validates :year, presence: true, uniqueness: true
end
