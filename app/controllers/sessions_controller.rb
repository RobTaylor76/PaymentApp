class SessionsController < ApplicationController

  skip_before_action :require_logged_in_user, :only => [:new, :create, :destroy]

  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user.present? && user.authenticate(params[:sessions][:password])
      login_user(user)
      redirect_to menu_path
    else
    #  flash.now[:danger] = 'Invalid Email/Password Combination'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
