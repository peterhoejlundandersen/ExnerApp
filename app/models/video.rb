class Video < ApplicationRecord
  mount_uploader :link_image, LinkImageUploader
  validates_presence_of :title
end
