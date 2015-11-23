class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
 # 内容は必須入力かつ2文字以上30文字以下
  validates :profile , length: { minimum: 2, maximum: 200 } , presence: true
  validates :from , length: { minimum: 1, maximum: 10 } , presence: true
    has_secure_password
end
