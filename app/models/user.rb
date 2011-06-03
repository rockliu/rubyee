require 'digest/sha2'

class User < ActiveRecord::Base
    
    attr_protected :hashed_password,:enabled
    attr_accessor :password
    
    has_and_belongs_to_many :roles
    
    has_many :articles
    has_many :entries
    has_many :comments
    
    #非空验证
    validates_presence_of :username,:message => '用户名不能为空。'
    validates_presence_of :email,:message => '电子邮件不能为空。'
    validates_presence_of :password, :message => '密码不能为空。',:if => :password_required?
    validates_presence_of :password_confirmation,:message => '密码确认不能为空。',:if => :password_required?

    validates_confirmation_of :password,:if => :password_required?
    
    #唯一性验证
    validates_uniqueness_of :username,:case_sensitive => false,
                            :message => '用户名不能重复。'
    validates_uniqueness_of :email,:case_sensitive => false,
                            :message => '电子邮件不能重复。'
     
    #长度验证
    validates_length_of :username,:within => 3..64,
                        :message => '用户名最小3个字符，至多64个字符。'
    validates_length_of :email,:within => 5..128,
                        :message => '电子邮件最小5个字符，至多64个字符。'
    validates_length_of :password,:within => 4..20,:if => :password_required?,
                        :message => '密码最小5个字符，至多64个字符。'
    validates_length_of :profile,:maximum=>1000

    def before_save
	self.hashed_password = User.encrypt(password) if !self.password.blank?
    end

    def password_required?
        self.hashed_password.blank? || !self.password.blank?
    end
    
    #使用SHA256散列算法对密码进行加密
    def self.encrypt(string)
	return Digest::SHA256.hexdigest(string)
    end

    #检查用户登录凭证
    def self.authenticate(username,password)
        find_by_username_and_hashed_password_and_enabled(username,User.encrypt(password),true)
    end
    
    def has_role?(rolename)
	self.roles.find_by_name(rolename)
    end
    
end
