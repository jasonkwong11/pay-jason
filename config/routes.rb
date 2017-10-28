Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'booking', to: 'booking#index'
  resources :booking
  resources :charges

  get 'alipay', to: 'charges#alipay'
  get 'confirmation', to: 'charges#confirmation'
end
