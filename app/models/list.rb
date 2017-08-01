class List < ActiveRecord::Base
  belongs_to :selection
  has_many :user_votes, class_name: "Voter"
  has_many :voters, source: :user, through: :user_votes

  def board
    {
      president_id: "Başkan",
      vice_president_id: "Başkan Yardımcısı",
      accountant_id: "Sayman",
      secretary_id: "Sekreter",
      member_one: "1. Üye",
      member_two: "2. Üye",
      member_three: "3. Üye"
    }
  end
end
