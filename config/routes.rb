Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'booking#index'
  resources :booking
  resources :charges

  get 'alipay', to: 'charges#alipay'
  get 'pending', to: 'charges#pending'
  get 'confirmation', to: 'charges#confirmation'

  get 'about', to: 'booking#about'
  get 'free', to: 'booking#free'

  post 'stripe-events', to: 'charges#webhook'

  get 'failed', to: 'charges#failed'
  get 'cancelled', to: 'charges#cancelled'
  get 'yay', to: 'charges#yay'

 # mount StripeEvent::Engine, at: '/stripe-events'

end
