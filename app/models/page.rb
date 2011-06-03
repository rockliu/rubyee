class Page < ActiveRecord::Base
	validates_presence_of :title,:message => '标题不能为空。'
	validates_presence_of :body,:message => '内容不能为空。'
        validates_length_of :title,:within => 3..255,:message=>'标题最少需要3个字符'
	validates_length_of :body,:maximum => 10000,:message=>'内容最多10000个字符'
        def before_create
        	@attributes['permalink']=
                	title.gsub(/\s+/,'_')
        end
        def to_param
        	"#{id}-#{permalink}"
        end
end
