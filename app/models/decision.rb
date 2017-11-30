class Decision < ActiveRecord::Base
  validates :name, presence: true
  validates :file, presence: true

  mount_uploader :file, FileUploader
end
