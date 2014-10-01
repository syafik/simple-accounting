SimpleAccounting::Application.routes.draw do

  resources :roles
  
  resources :absents
  resources :salaries
  resources :manage_users


  
  



  # get "allowance_sub_categories/index"

  # get "allowances/index"

  match "/loan_payments/:id/new" => "loan_payments#new",   :as => "new_loan_payments",  :via => :get
  match "/loan_payments/:id/edit" => "loan_payments#edit",   :as => "edit_loan_payments",  :via => :get
  match "/absents/:id/set_attend" => "absents#set_attend",   :as => "set_absent_attend",  :via => :get
  match "/salary_histories/:user_id/new" => "salary_histories#new",   :as => "new_salary_history",  :via => :get
  match "/settings/overtime" => "settings#overtime", :as => "overtime_setting", :via => :get
  match "/settings/overtime_create" => "settings#overtime_create", :as => "overtime_create", :via => :post
  get '/salary_histories/:id/user', to: 'salary_histories#index', as: 'salary_histories_user'


  resources :allowance_categories do
    resources :allowance_sub_categories
  end

  # resources :settings do
  #   member do
  #     post :overtime_create
  #   end
  # end

  resources :allowance_claim_transactions do
    collection do
      get :set_approval
    end
  end

  resources :overtime_payment_histories do
    member do
      get :set_activation
      get :index
    end
  end

  resources :allowances do 
    collection do
      get :find_available_category
    end
  end

  resources :salary_histories do
    member do
      get :set_activation
    end
  end

  resources :absent_permissions do
    member do
      get :set_approval
      get :set_taken
      get :set_decline
    end
  end

  resources :overtimes do
    member do
      get :set_approval
      get :set_rejected
    end
  end

  resources :loan_permissions do
    member do
      get :set_approval
      get :set_taken
      get :set_decline
    end
  end

  resources :loan_payments do
    member do
      get :set_approval
    end
  end

  resources :allowance_sub_categories
  devise_for :users, controllers: {sessions: :sessions}

  resources :transactions, :reports do
    collection do
      post :credit
      get :new_credit
      get :edit_transaction
      get :reporting
    end
  end
  #resources :claim_transactions
  root :to => 'absents#index'

 #resources :users do
 # resources :claim_transactions
 #end




end
