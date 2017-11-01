Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'booking#index'
  resources :booking
  resources :charges

  get 'alipay', to: 'charges#alipay'
  get 'pending', to: 'charges#pending'
  get 'confirmation', to: 'charges#confirmation'

  mount StripeEvent::Engine, at: '/stripe-events'

end
