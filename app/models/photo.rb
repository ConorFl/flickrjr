class Photo < ActiveRecord::Base
  belongs_to :gallery

   mount_uploader :file, PhotoUploader
end
