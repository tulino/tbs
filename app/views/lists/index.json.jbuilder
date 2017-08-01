json.array!(@lists) do |list|
  json.extract! list, :id, :president_id, :vice_president_id, :accountant_id, :secretary_id, :member_one, :member_two, :member_three, :vote_count, :selection_id
  json.url list_url(list, format: :json)
end
