class ClubCategory < ActiveRecord::Base
  has_many :clubs

  def vocational_club?
    name == 'Mesleki Topluluk'
  end

  def self.lower_limits
    { vocational_club: 15, social_club: 30 }
  end
end
