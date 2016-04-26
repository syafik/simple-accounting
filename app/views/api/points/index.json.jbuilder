json.month_point @histories.sum(:points)
json.year_point @yearpoints.sum(:points)
json.point_histories @histories
json.point_histories @histories.limit(10) do |content|
    json.created_at content.created_at.strftime("%b %d, %Y")
    json.point_historyable_type content.point_historyable_type
    json.points content.points
  end
