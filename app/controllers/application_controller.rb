class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_navigation_presenter
  before_action :authenticate_user!, except: [:show]

  def load_navigation_presenter
    @navigation_presenter = NavigationPresenter.new(current_user, user_signed_in?)
  end
end
