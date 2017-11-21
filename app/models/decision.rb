class Decision < ActiveRecord::Base
  validates :name, presence: true
  validates :file, presence: true
  
  mount_uploader :file, FileUploader

  def self.search(query)
    where('lower(name) like ?', "%#{query}%".downcase)
  end
end
