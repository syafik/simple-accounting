json.reimburs @year_insurances do |yi|
  json.name yi.family.name
  json.status yi.family.status.to_s
  json.grade yi.grade.name
  json.family_id yi.family.id
end
