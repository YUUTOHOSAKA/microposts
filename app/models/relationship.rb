class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"#Userクラスのオブジェクト
  belongs_to :followed, class_name: "User"#Userクラスのオブジェクト
end