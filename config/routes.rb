SimpleAccounting::Application.routes.draw do

  resources :roles

  resources :absents
  resources :overtimes
  resources :salaries
  resources :manage_users

  resources :overtime_payment_histories
  



  # get "allowance_sub_categories/index"

  # get "allowances/index"

match "/loan_payments/:id/new" => "loan_payments#new",   :as => "new_loan_payments",  :via => :get
match "/loan_payments/:id/edit" => "loan_payments#edit",   :as => "edit_loan_payments",  :via => :get

  resources :allowance_categories do
    resources :allowance_sub_categories
  end

  resources :allowance_claim_transactions do
    collection do
      get :set_approval
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
  root :to => 'transactions#index'

 #resources :users do
 # resources :claim_transactions
 #end




end
