class Topic < ActiveRecord::Base
  belongs_to :forum,:counter_cache => true
  belongs_to :user
  has_many :posts, :dependent => :delete_all
  
  #数据验证
  validates_presence_of :name,:message => '主题标题不能为空。'
  validates_length_of :name,:maximum => 255,
                      :message => '主题标题最多255个字符。'
end
