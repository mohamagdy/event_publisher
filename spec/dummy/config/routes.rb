Rails.application.routes.draw do
  resources :articles, only: [:index, :show]

  devise_for :users

  mount EventPublisher::Engine => "/event_publisher"
end
