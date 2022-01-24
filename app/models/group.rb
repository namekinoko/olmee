class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users, dependent: :destroy
  has_many :chats, dependent: :destroy

  # グループモデルのvalidation
  validate :check_date
  validates :user_id, presence: true
  validates :date, presence: true
  validates :prefecture, presence: true, format: {with: /\A.{2,}[都道府県]$\z/}
  validates :purpose, presence: true
  validates :number, presence: true
  validates :content, presence: false, length: { maximum: 240 }
  validates :prefecture, presence: true

  # 募集期日が過ぎた場合自動的に削除する用メゾット
  def self.delete_group
    @group = Group.where("date < ?", Date.today )
    @group.destroy_all
  end 

  private
    #  入力された日付が今日以降のものかチェック
    def check_date
      if self.date < Date.today
      errors.add(:date, "は今日以降のものを選択してください")
      end
    end
end
