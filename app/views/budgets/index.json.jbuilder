json.array!(@budgets) do |budget|
  json.extract! budget, :descript, :amout
  json.url budget_url(budget, format: :json)
end
