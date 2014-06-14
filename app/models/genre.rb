class Genre < ActiveRecord::Base
  # associations
  has_many :albums

  # validations
  validates :name, presence: true, uniqueness: true
end
