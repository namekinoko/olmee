class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :group_users
  has_many :groups, dependent: :destroy, through: :group_users
  has_many :chats
  before_save   :downcase_email
  before_create :create_activation_digest

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :nickname, presence: true, uniqueness:true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 永続セッション用ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 渡された文字列のハッシュ値を返す
  def User.digest( string )
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create( string, cost: cost )
  end

  # 永続セッションのためユーザーをデータベースに記憶する(:remenber_digestにremember_tokenを)
  def remember
    self.remember_token = User.new_token
    update_attribute( :remember_digest, User.digest( remember_token ) )
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?( attribute, token )
    digest = send( "#{attribute}_digest" )
    return false if digest.nil?
    BCrypt::Password.new( digest ).is_password?( token )
  end

  # ユーザーのログイン情報を破棄する(ログアウトのため)
  def forget
    update_attribute( :remember_digest, nil )
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute( :reset_digest,  User.digest( reset_token ) )
    update_attribute( :reset_sent_at, Time.zone.now )
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset( self ).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private
    # メールアドレスをすべて小文字に
    def downcase_email
      self.email = email.downcase
    end

    # アカウント有効化トークンとダイジェストを作成および代入
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest( activation_token )
    end

end
