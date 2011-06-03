class AccountController < ApplicationController
  def login
  end

  def authenticate
      self.logged_in_user = User.authenticate(params[:user][:username],params[:user][:password])
      if is_logged_in?
          redirect_to index_url
      else
          flash[:error] = "用户名或密码不正确。"
          redirect_to :action => 'login'
      end
  end

  def logout
      if request.post?
          reset_session
      end
      redirect_to index_url
  end

end
