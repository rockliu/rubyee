class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  
  before_save :update_published_at
  
  validates_presence_of :title,:message => '标题不能为空。'
  validates_presence_of :synopsis,:message => '摘要不能为空。'
  validates_presence_of :body,:message => '内容不能我为空。'
  
  validates_length_of :title,:maximum => 255, :message => '标题最多255个字符。'
  validates_length_of :synopsis,:maximum => 1000, :message => '标题最多1000个字符。'
  validates_length_of :body,:maximum => 20000, :message => '标题最多20000个字符。'

  def update_published_at
    self.published_at = Time.now if published == true
  end
end
