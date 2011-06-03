class UsersController < ApplicationController
  before_filter :check_admin_role,
                :only => [:index,:destroy,:enable]
  before_filter :login_required, :only => [:edit,:update]
  
  def index
      @users = User.find(:all)
  end

  def show
      @user = User.find(params[:id])
      @entries = @user.entries.find(:all,:limit => 3,:order => 'created_at DESC')
  end
 
  def show_by_username
      @user = User.find_by_username(params[:username])
      render :action => 'show'
  end

  def new
      @user=User.new
  end

  def create
      @user = User.new(params[:user])
      if @user.save
          self.logged_in_user = @user
          flash[:notice] = "您的账户创建成功。"
          redirect_to index_url
      else
          render :action => 'new'
      end
  end

  def edit
     @user = logged_in_user
  end

  def update
     @user = User.find(logged_in_user)
     if @user.update_attributes(params[:user])
         flash[:notice] = "用户已被更新。"
         redirect_to :action => 'show', :id => logged_in_user
     else
         render :action => 'edit'
     end
  end

  def destroy
     @user = User.find(params[:id])
     if @user.update_attribute(:enabled,false)
         flash[:notice] = "用户已被禁用。"
     else
         flash[:error] = "用户禁用时出错。"
     end
     redirect_to :action => 'index'
  end

  def enable
      @user = User.find(params[:id])
     if @user.update_attribute(:enabled,true)
         flash[:notice] = "用户已被启用。"
     else
         flash[:error] = "用户启用时出错。"
     end
     redirect_to :action => 'index'
  end

end
