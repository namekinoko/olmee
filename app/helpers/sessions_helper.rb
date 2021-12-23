module SessionsHelper

  # 新規登録またはログイン（ページ）時にログインする
  def log_in( user )
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的に
  # cookieにユーザーIDと記憶トークンを保存
  def remember( user )
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 記憶トークンcookieに対応するユーザーを返す
  # セッションがない場合、cookieに保存してあるIDと記憶トークンを使って、ユーザーを取得
  def current_user
    if ( user_id = session[:user_id] )
      @current_user ||= User.find_by(id: user_id)
    elsif ( user_id = cookies.signed[:user_id] )
      user = User.find_by( id: user_id )
      if user && user.authenticated?( cookies[:remember_token] )
        log_in user
        @current_user = user
      end
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

  # 永続的セッションを破棄する(cookieからIDと記憶トークンを消す)
  def forget( user )
    user.forget
    cookies.delete( :user_id )
    cookies.delete( :remember_token )
  end

  # 現在のユーザーからログアウト
  def log_out
    forget( current_user )
    session.delete( :user_id )
    @current_user = nil
  end

  # 記憶したURL（もしくはサービスページ）にリダイレクト
  def redirect_back_or_service
    redirect_to( session[:forwarding_url] || services_url )
    session.delete( :forwarding_url )
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
