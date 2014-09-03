SimpleAccounting::Application.routes.draw do
  resources :absents
  resources :overtimes
  resources :salaries
  resources :manage_users
  resources :salary_histories

  get "allowance_sub_categories/index"

  get "allowances/index"



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
