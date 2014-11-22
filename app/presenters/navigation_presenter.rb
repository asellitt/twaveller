class NavigationPresenter

  def initialize(current_user, user_signed_in)
    @current_user = current_user
    @user_signed_in = user_signed_in
  end

  def application_name
    'Twaveller'
  end

  def username
    current_user.email
  end

  def user_signed_in?
    !!user_signed_in
  end

private

  attr_reader :current_user, :user_signed_in

end
