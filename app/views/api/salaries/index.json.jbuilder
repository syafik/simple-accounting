json.gaji_pokok number_to_currency(@salary.salary_history.payment,unit: "Rp. ")
json.gaji_lembur number_to_currency(@salary.total_overtime_payment,unit: "Rp. ")
json.etc number_to_currency(@salary.etc,unit: "Rp. ").to_s
json.jamsostek number_to_currency(@salary.jamsostek,unit: "Rp. ")
json.potongan number_to_currency(@total_potongan , unit: "Rp. ")
json.transport  number_to_currency(@salary.transport, unit: "Rp. ")
json.thp number_to_currency(@salary.thp, unit: "Rp. ")
json.total  number_to_currency(@total_pendapatan, unit: "Rp. ")
json.dikirim @salary.date.strftime("%d-%B-%Y")
