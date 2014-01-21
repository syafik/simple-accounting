module ApplicationHelper

  def number_to_rupiah_currency(number, html=true)
    number = number.to_s
      rs = ""
      number.reverse.chars.each_with_index{|i, index| rs<<i; rs<<"," if index==2; rs<<"," if (index!=number.chars.count-1&&index>3&&index%2==0) }
      rs = rs.reverse
      return "Rp.  " + rs
  end

end
