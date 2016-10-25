class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :user_activity

  private

  # Método que permite saber cuando un usuario se encuentra online
  def user_activity
    current_user.try :touch
  end
end
