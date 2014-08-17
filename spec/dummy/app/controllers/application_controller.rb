class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    migrate_events_after_login(resource)
    super
  end
end
