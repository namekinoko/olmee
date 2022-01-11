class Group < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 240 }
  validates :prefecture, presence: true

end
