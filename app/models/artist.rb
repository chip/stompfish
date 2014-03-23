require 'elasticsearch/model'

class Artist < ActiveRecord::Base
  include Elasticsearch::Model

  # associations
  has_many :albums
  has_many :songs

  # validations
  validates :name, presence: true, uniqueness: true
end
