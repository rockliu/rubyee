class PagesController < ApplicationController
  before_filter :check_admin_role,
                :except => :show
                
  def index
	@pages = Page.find(:all)
  end

  def show
	@page = Page.find(params[:id].to_i)
  end

  def new
	@page = Page.new
  end

  def create
	@page = Page.new(params[:page])
	@page.save!
	flash[:notice]='页面保存成功。'
	redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
	render :action => 'new'
  end

  def edit
	@page = Page.find(params[:id].to_i)
  end

  def update
	@page = Page.find(params[:id].to_i)
	@page.attributes = params[:page]
	@page.save!
	flash[:notice] = "页面更新成功。"
	redirect_to :action => 'index'
  rescue
	render :action => 'edit'
  end

  def destroy
	@page =Page.find(params[:id].to_i)
	if @page.destroy
		flash[:notice] = "页面已删除。"
        else
		flash[:notice] = "页面删除失败。"
        end
	redirect_to :action => 'index'
  end
  
  def show_index
    @articles = Article.find(:all)
    @topics = Topic.find(:all)
    @entries = Entry.find(:all)
  end

end
