class SessionsController < ApplicationController


  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user.present? && user.authenticate(params[:sessions][:password])
      login_user(user)
      redirect_to payments_path
    else
    #  flash.now[:danger] = 'Invalid Email/Password Combination'
      render :new
    end
  end

  def destroy
    logout
  end
end
