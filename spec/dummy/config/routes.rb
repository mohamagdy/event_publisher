Rails.application.routes.draw do

  resources :articles


  devise_for :users

  mount EventPublisher::Engine => "/event_publisher"
end
