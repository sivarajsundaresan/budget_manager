Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'budgets#index'
  resources :budgets

  post '/category_record' => 'budgets#category_record'
  post '/filter_record' => 'budgets#filter_record'
  get "download_pdf" => 'budgets#download_pdf'
  get 'category/new' => 'categories#form'
  post 'category_create' => 'categories#create'
  
end
