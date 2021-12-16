module SessionsHelper

  # 新規登録またはログイン（ページ）時にログインする
  def log_in( user )
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す（セッション）
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by( id: session[:user_id] )
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

end
