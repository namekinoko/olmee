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

  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?( user )
    user && user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーからログアウト
  def log_out
    session.delete( :user_id )
    @current_user = nil
  end

  # 記憶したURL（もしくはサービスページ）にリダイレクト
  def redirect_back_or_service
    redirect_to( session[:forwarding_url] || service_url )
    session.delete( :forwarding_url )
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
