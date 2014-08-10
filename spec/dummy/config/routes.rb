Rails.application.routes.draw do

  mount EventPublisher::Engine => "/event_publisher"
end
