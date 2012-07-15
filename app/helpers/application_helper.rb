module ApplicationHelper
  def sign_in(user)
    @user_session = UserSession.new(user)
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

end
