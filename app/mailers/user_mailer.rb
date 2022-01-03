class UserMailer < ApplicationMailer
# 新規登録時アカウント認証をお願いするメールを送る
  def account_activation( user )
    @user = user
    mail to: user.email, subject: "Olmeeアカウント認証"
  end
# ユーザーがパスワードを忘れた時に送る
  def password_reset( user )
    @user = user
    mail to: user.email, subject: "パスワード再設定 | Olmee(オルミー)"
  end
end
