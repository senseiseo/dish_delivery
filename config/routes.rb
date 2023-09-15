Rails.application.routes.draw do
  get '/orders', to: 'orders#index'
  post '/create_order', to: 'orders#create', as: 'create_order'
  get '/admin_crm', to: 'orders#crm'
end
