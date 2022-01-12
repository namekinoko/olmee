class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 240 }
  validates :prefecture, presence: true

end
