require 'elasticsearch/model'

class Album < ActiveRecord::Base
  include Elasticsearch::Model

  # associations
  belongs_to :artist
  belongs_to :genre
  belongs_to :release_date
  has_many :songs

  # validations
  validates_presence_of :artist_id, :title
  validates_uniqueness_of :title, scope: :artist_id

  # delegations
  delegate :name, to: :genre, prefix: true
  delegate :year, to: :release_date
end
