json.array!(@selections) do |selection|
  json.extract! selection, :id, :start_list_creation_date, :end_list_creation_date, :allow_list_creation, :start_selection_date, :end_selection_date, :allow_selection
  json.url selection_url(selection, format: :json)
end
