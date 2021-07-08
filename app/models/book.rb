class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  has_many :book_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: { maximum: 200 }

# 　# 検索方法分岐
#   def self.looks(search, word)
#     if search == "perfect_match"
#       @book = Book.where("title LIKE?","#{word}")
#     elsif search == "forward_match"
#       @book = Book.where("title LIKE?","#{word}%")
#     elsif search == "backward_match"
#       @book = Book.where("title LIKE?","%#{word}")
#     elsif search == "partial_match"
#       @book = Book.where("title LIKE?","%#{word}%")
#     else
#       @book = Book.all
#     end
#   end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
end
