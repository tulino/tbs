module ListsHelper
  
  def did_vote?(selection, user)
    selection.lists.map{|list| list.voters.pluck(:id)}.flatten.include?(user.id)
  end

end
