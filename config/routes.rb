SimpleAccounting::Application.routes.draw do
  devise_for :users
 

  resources :transactions, :reports do
  collection do
    post :credit
    get :new_credit
    get :edit_transaction
    get :reporting
  end
  end
  get "home/index"

  
 root :to => 'home#index'

  
end
