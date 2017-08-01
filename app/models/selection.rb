class Selection < ActiveRecord::Base
  belongs_to :club
  has_many :lists
end
