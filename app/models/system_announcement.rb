class SystemAnnouncement < ActiveRecord::Base
  enum status: %i[onemli genel haber]
  paginates_per 6
  def self.search(query)
    where('lower(title) like ?', "%#{query}%".downcase)
  end

  def onemli?
    SystemAnnouncement.onemli.include? self
  end

  def genel?
    SystemAnnouncement.genel.include? self
  end

  def haber?
    SystemAnnouncement.haber.include? self
  end
end
