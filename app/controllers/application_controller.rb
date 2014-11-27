class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_navigation_presenter
  before_action :authenticate_user!

  rescue_from User::NotAuthorized, with: :user_not_authorized

  def load_navigation_presenter
    @navigation_presenter = NavigationPresenter.new(current_user, user_signed_in?)
  end

private

  def user_not_authorized
    flash[:error] = 'These are not the droids you are looking for'
    if request.env['HTTP_REFERER']
      redirect_to :back
    else
      redirect_to trips_path
    end
  end

end
