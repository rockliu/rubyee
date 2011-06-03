class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.xml
  def index
    @forum = Forum.find(params[:forum_id])
    @topics_pages,@topics = paginate(
      :topics,
      :include => :user,
      :conditions => ['forum_id = ?',@forum],
      :order => 'topics.updated_at DESC'
    )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics.to_xml }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    redirect_to forum_topic_posts_path(:forum_id => params[:forum_id],:topic_id => params[:id])
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
    @post = Post.new
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new( :name => params[:topic][:name],
                       :forum_id => params[:forum_id],
                       :user_id => logged_in_user.id )
    @topic.save!
    
    @post = Post.new( :body => params[:post][:body],
                     :topic_id => @topic.id,
                     :user_id => logged_in_user.id )
    @post.save!
    
    respond_to do |format|
        format.html { redirect_to forum_topic_posts_path(:topic_id => @topic,
                                             :forum_id => @topic.forum.id) }
        format.xml  { head :created,:location => forum_topic_path(:id => @topic,
                                                            :forum_id => @topic.forum.id) }
    end
  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render :action => 'new' }
      format.xml  { render :xml => @post.errors.to_xml }
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = '主题更新成功。'
        format.html { redirect_to forum_topics_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors.to_xml }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    @topic.posts.each{ |post| post.destroy }
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to forum_topics_path(:forum_id => params[:forum_id]) }
      format.xml  { head :ok }
    end
  end
end
