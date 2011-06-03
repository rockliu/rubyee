class Forum < ActiveRecord::Base
  has_many :topics, :dependent => :delete_all
  has_many :posts,:through => :topics
  
  #数据验证
  validates_presence_of :name,:message => '讨论区名称不能为空。'
  validates_length_of :name, :maximum => 100,
                      :message => '讨论区名称最多100个字符。'
  validates_length_of :description,:maximum => 300,
                      :message => '讨论区描述最多300个字符。'
end
