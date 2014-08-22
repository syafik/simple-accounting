SimpleAccounting::Application.routes.draw do
  get "allowance_sub_categories/index"

  get "allowances/index"

  resources :allowance_categories
  resources :claim_transactions
  resources :allowances do 
    collection do
      get :find_sub_categories
    end
  end
  resources :allowance_sub_categories
  devise_for :users

  resources :transactions, :reports do
    collection do
      post :credit
      get :new_credit
      get :edit_transaction
      get :reporting
    end
  end
   resources :claim_transactions
 root :to => 'transactions#index'

 #resources :users do
 # resources :claim_transactions
 #end
	


  
end
