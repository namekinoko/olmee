class SessionsController < ApplicationController

  def new
  end

  # ログインに成功した場合サービスページへ。失敗した場合再度ログインページに
  def create
    user = User.find_by( email: params[:session][:email].downcase )
    if user && user.authenticate( params[:session][:password] )
      if user.activated?
        log_in( user )
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or_service
      else
        message  = "アカウントが認証されていません。 "
        message += "メールを確認して、アカウントを認証してください。"
        flash[:warning] = message
        redirect_to( root_url )
      end
    else
      flash.now[:danger] = 'パスワード又はメールアドレスが違います。'
      render 'new'
    end
  end

  # ログアウトしたらトップページに戻る
  def destroy
    log_out if logged_in?
    redirect_to( root_url )
  end

end
