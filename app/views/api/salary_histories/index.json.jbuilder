json.salary_histories @salary_histories do |sh|
  json.tanggal sh.applicable_date
  json.gaji number_to_currency(sh.payment,unit: "Rp. ")
end
