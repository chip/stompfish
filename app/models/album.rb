require 'elasticsearch/model'

class Album < ActiveRecord::Base
  include Elasticsearch::Model

  belongs_to :artist
  has_many :songs

  validates_presence_of :artist_id, :title
  validates_uniqueness_of :title, scope: :artist_id
end
