class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        # :authentication_keys => [:username]

  validates :name, presence: true
  validates :name, length: { in: 2..20  }
  validates :name, uniqueness: true

  validates :introduction, length: { maximum: 50 }

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     #認証の条件式を変更する
  #     where(conditions).where(["name = :value", { :value => name }]).first
  #   else
  #     where(conditions).first
  #   end
  # end

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy # フォロー取得/suru
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得/sareru

  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :following_user, through: :relationships, source: :followed # 自分がフォローしている人
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :follower_user, through: :reverse_of_relationships, source: :follow # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
  relationships.create(followed_id: user_id)
  end

# ユーザーのフォローを外す
  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end

# フォローしていればtrueを返す
  def following?(user)
  following_user.include?(user)
  end




  attachment :profile_image

  validates :name, presence: true


end
