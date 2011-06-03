class Category < ActiveRecord::Base
  has_many :articles, :dependent => :nullify
  
  validates_length_of :name,:maximum => 80 ,:message => '分类名称长度最多80个字符。'
end
