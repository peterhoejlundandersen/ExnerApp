class Video < ApplicationRecord
  mount_uploader :link_image, LinkImageUploader
  validates_presence_of :title
  default_scope { order(year: :asc) }
end
