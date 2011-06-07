class Comment < ActiveRecord::Base
  belongs_to :entry,:counter_cache => true
  belongs_to :user
  
  validates_length_of :body,:maximum => 1000,:message => '评论最大长度为1000个字符。'
end
