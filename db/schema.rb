# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20141104040704) do

  create_table "absent_permissions", :force => true do |t|
    t.integer  "category"
    t.date     "submission_date"
    t.date     "approval_date"
    t.integer  "long"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.text     "message"
    t.integer  "status"
  end

  add_index "absent_permissions", ["user_id"], :name => "index_absent_permissions_on_user_id"

  create_table "absents", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.integer  "categories"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.time     "time_in"
    t.time     "time_out"
    t.float    "total_work_time"
  end

  create_table "account_receivables", :force => true do |t|
    t.string   "title"
    t.integer  "debit"
    t.integer  "credit"
    t.text     "description"
    t.datetime "date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "allowance_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "allowance_claim_transactions", :force => true do |t|
    t.date     "submission_date"
    t.date     "approval_date"
    t.string   "upload"
    t.text     "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "allowance_id"
    t.float    "nominal"
    t.integer  "status"
  end

  add_index "allowance_claim_transactions", ["allowance_id"], :name => "index_allowance_claim_transactions_on_allowance_id"

  create_table "allowance_sub_categories", :force => true do |t|
    t.string   "name"
    t.integer  "allowance_category_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "max_day"
  end

  add_index "allowance_sub_categories", ["allowance_category_id"], :name => "index_allowance_sub_categories_on_allowance_category_id"

  create_table "allowances", :force => true do |t|
    t.float    "value"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "allowance_sub_category_id"
  end

  add_index "allowances", ["allowance_sub_category_id"], :name => "index_allowances_on_allowance_sub_category_id"
  add_index "allowances", ["user_id"], :name => "index_allowances_on_user_id"

  create_table "loan_payments", :force => true do |t|
    t.date     "submission_date"
    t.date     "approval_date"
    t.float    "total_payment"
    t.text     "message"
    t.text     "description"
    t.integer  "loan_permission_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "status"
    t.date     "payment_date"
  end

  add_index "loan_payments", ["loan_permission_id"], :name => "index_loan_payments_on_LoanPermission_id"

  create_table "loan_permissions", :force => true do |t|
    t.date     "submission_date"
    t.date     "approval_date"
    t.float    "total_loan"
    t.text     "message"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "status"
  end

  add_index "loan_permissions", ["user_id"], :name => "index_loan_permissions_on_users_id"

  create_table "overtime_payment_histories", :force => true do |t|
    t.date     "applicable_date"
    t.float    "day_payment"
    t.float    "night_payment"
    t.boolean  "activate"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.datetime "deleted_at"
  end

  add_index "overtime_payment_histories", ["deleted_at"], :name => "index_overtime_payment_histories_on_deleted_at"
  add_index "overtime_payment_histories", ["user_id"], :name => "index_overtime_payment_histories_on_user_id"

  create_table "overtimes", :force => true do |t|
    t.date     "date"
    t.integer  "user_id"
    t.string   "description"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.float    "long_overtime"
    t.float    "payment"
    t.float    "day_payment"
    t.float    "night_payment"
    t.integer  "status"
    t.float    "long_day",      :default => 0.0
    t.float    "long_night",    :default => 0.0
    t.datetime "start_time"
    t.datetime "end_time"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.datetime "deleted_at"
  end

  add_index "roles", ["deleted_at"], :name => "index_roles_on_deleted_at"

  create_table "salaries", :force => true do |t|
    t.date     "date"
    t.integer  "total_attendance"
    t.integer  "total_absence"
    t.integer  "total_overtime_hours"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.float    "total_overtime_payment"
    t.integer  "salary_history_id"
    t.float    "jamsostek"
    t.float    "thp"
    t.boolean  "transfered"
    t.float    "etc"
  end

  create_table "salary_histories", :force => true do |t|
    t.integer  "user_id"
    t.float    "payment"
    t.date     "applicable_date"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "activate"
    t.datetime "deleted_at"
    t.float    "day_payment_overtime"
    t.float    "night_payment_overtime"
  end

  add_index "salary_histories", ["deleted_at"], :name => "index_salary_histories_on_deleted_at"

  create_table "salary_schedules", :force => true do |t|
    t.date     "date"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "status",     :default => false
    t.date     "first_date"
    t.date     "end_date"
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "transaction_summaries", :force => true do |t|
    t.string   "name"
    t.integer  "summary_month"
    t.integer  "summary_year"
    t.integer  "debit",         :limit => 8
    t.integer  "credit",        :limit => 8
    t.integer  "total",         :limit => 8
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "transactions", :force => true do |t|
    t.datetime "date"
    t.string   "description"
    t.integer  "value"
    t.boolean  "is_debit",    :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "is_close",    :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "telephone"
    t.string   "address"
    t.date     "date_entry"
    t.boolean  "gender"
    t.string   "religion"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.integer  "role_id"
    t.datetime "deleted_at"
    t.integer  "max_furlough"
    t.string   "position"
    t.string   "account_number"
    t.string   "bank_name"
    t.string   "account_branch_name"
    t.string   "account_name"
    t.boolean  "allowed_jamsostek"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["deleted_at"], :name => "index_users_on_deleted_at"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
