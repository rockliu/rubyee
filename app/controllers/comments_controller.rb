class CommentsController < ApplicationController
  before_filter :login_required

  # POST /comments
  # POST /comments.xml
  def create
    @entry = Entry.find_by_user_id_and_id(params[:user_id],params[:entry_id])
    @comment = Comment.new(:user_id => @logged_in_user.id,
                           :body => params[:comment][:body])

    if @entry.comments << @comment
      flash[:notice] = "评论成功。"
      redirect_to entries_path(:user_id => @entry.user,:entry_id => @entry)
    else
      render :controller => 'entries',:action => 'show',
             :user_id => @entry.user,:entry_id => @entry
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @entry = Entry.find_by_user_id_and_id(@logged_in_user.id,
                                          params[:entry_id],
                                          :include => :user)
    @comment = @entry.comments.find(params[:id])
    @comment.destroy

    redirect_to entry_path(:user_id => @entry.user.id,:id => @entry.id)
  end
end
