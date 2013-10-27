class TagGroup < ActiveRecord::Base
  attr_accessible :title

  has_many :tags

  validates :title, presence: true, uniqueness: true
end
