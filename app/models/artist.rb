require 'elasticsearch/model'

class Artist < ActiveRecord::Base
  include Elasticsearch::Model

  # associations
  has_many :albums, dependent: :destroy
  has_many :songs

  # validations
  validates :name, presence: true, uniqueness: true

  def albums_by_date
    albums.sort_by(&:year)
  end
end
