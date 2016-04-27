json.sisa @sisa
json.histories @histories.each do |history|
  json.bayar history.bayar.to_s
  json.borrower_id history.borrower_id
  json.borrower_type history.borrower_type
  json.created_at history.created_at
  json.credit history.credit
  json.date history.date.strftime("%b %d, %Y")
  json.debit history.debit
  json.description history.description
  json.id history.id
  json.parent_id history.parent_id.to_s
  json.time history.time.to_s
  json.title history.title
  json.updated_at history.updated_at
end
