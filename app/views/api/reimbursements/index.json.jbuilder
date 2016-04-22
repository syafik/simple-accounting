json.reimburs @year_insurances do |yi|
  json.name yi.family.name
  if yi.family.status.nil?
    json.status "karyawan"
  else
    json.status yi.family.status.to_s
  end
  json.grade yi.grade.name
  json.family_id yi.family.id
end
