  json.name @year_insurances.family.name
  json.status @year_insurances.family.status.to_s
  json.grade @year_insurances.grade.name
  json.rj number_to_currency(@year_insurances.grade.rj, unit: "Rp. ", precision: 0)
  json.ri number_to_currency(@year_insurances.grade.ri, unit: "Rp. ", precision: 0)
  json.operasi number_to_currency(@year_insurances.grade.operasi, unit: "Rp. ", precision: 0)
  json.reimbursement @year_insurances.reimbursements do |reimburs|
    json.created_at reimburs.created_at.strftime("%b %d, %Y")

    json.no_kwitasi reimburs.no_kwitasi
    json.rumah_sakit reimburs.rumah_sakit
    json.total_claim number_to_currency(reimburs.total_claim, unit: "Rp. ", precision: 0)
    json.total_approve  number_to_currency(reimburs.total_approve, unit: "Rp. ", precision: 0)
    json.status reimburs.status
    json.reimburs_type reimburs.reimbursement_type
    json.note reimburs.notes
  end
