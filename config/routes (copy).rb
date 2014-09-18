SimpleAccounting::Application.routes.draw do
  get "allowance_claim_transactions/index"

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
      get :find_sub_categories
    end
  end
  
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

 
	


  
end
