json.array! @year_insurances do |yi|
  json.name yi.family.name
  json.status yi.family.status
  json.grade yi.grade.name
  json.rj number_to_currency(yi.grade.rj, unit: "Rp. ", precision: 0)
  json.ri number_to_currency(yi.grade.ri, unit: "Rp. ", precision: 0)
  json.operasi number_to_currency(yi.grade.operasi, unit: "Rp. ", precision: 0)
end
