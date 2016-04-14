json.array! @year_insurances do |yi|
  json.name yi.family.name
  json.status yi.family.status
  json.grade yi.grade.name
end
