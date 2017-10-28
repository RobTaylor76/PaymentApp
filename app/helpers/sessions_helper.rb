module SessionsHelper

  def login_user(user)
    session[:user_id] = user.id
    session[:account_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_account
    @current_account ||= Account.find_by(id: session[:account_id])
  end

  def logged_in?
    current_user.present?
  end

  def logout
    session.delete[:user_id]
    session.delete[:account_id]
    @current_account = nil
    @current_user = nil
  end
end
