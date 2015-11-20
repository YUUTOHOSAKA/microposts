class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_many :microposts
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships, class_name:  "Relationship",#followed_idにuserのidが入る
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  #userをフォローしている人は、follower_relationshipsのfollower_idに一致するユーザーになるので、sourceとしてfollowerを指定しています
# 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end#followメソッドは、現在のユーザーのfollowing_relationshipsの中からフォローするユーザーのuser_idを含むものを探し、存在しない場合は、新しく作成します。find_or_create_byメソッドは引数のパラメータと一致するものを1件取得し、存在する場合はそのオブジェクトを返し、存在しない場合は引数の内容で新しくオブジェクトを作成し、データベースに保存します。

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
    #他のユーザーがfollowing_usersに含まれているかチェックしています。
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end