require 'elasticsearch/model'

class Artist < ActiveRecord::Base
  include Elasticsearch::Model

  has_many :albums
  has_many :songs

  validates :name, presence: true, uniqueness: true
end
