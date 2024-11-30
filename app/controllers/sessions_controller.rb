class SessionsController < ApplicationController

  def new
  end

  # digest, new_token, remember, authenticated?, forget メゾッドは User.rb に追加

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password])    # user && user.authenticate (has_secure_passwordによって提供) の短縮系
      reset_session      # セッション固定攻撃対策
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)    # remember_digest に値を保存
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

end




