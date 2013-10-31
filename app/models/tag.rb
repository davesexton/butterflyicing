class Tag < ActiveRecord::Base
  attr_accessible :tag_group_id, :title

  has_many :gallery_images
  belongs_to :tag_group

  validates :title, presence: true
end
