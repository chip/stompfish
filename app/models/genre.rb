require 'elasticsearch/model'

class Genre < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # associations
  has_many :albums

  # validations
  validates :name, presence: true, uniqueness: true
end
