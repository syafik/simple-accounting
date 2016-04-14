json.month_point @histories.sum(:points)
json.year_point @yearpoints.sum(:points)
json.point_histories @histories.limit(10)
