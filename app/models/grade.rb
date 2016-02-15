class Grade < ActiveRecord::Base
  attr_accessible :end_salary, :is_active, :name, :operasi, :rb_caesar, :rb_normal, :ri, :rj, :start_salary
  has_many :salary_histories
  has_many :year_insurance
end
