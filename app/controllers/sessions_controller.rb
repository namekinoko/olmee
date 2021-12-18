class SessionsController < ApplicationController

  def new
  end

  # ログインに成功した場合ユーザープロフィールページへ。失敗した場合再度ログインページに
  def create
    user = User.find_by( email: params[:session][:email].downcase )
    if user && user.authenticate( params[:session][:password] )
      log_in( user )
      redirect_to ( user )
    else
      flash.now[:danger] = 'パスワード又はメールアドレスが違います。'
      render 'new'
    end
  end

  # ログアウトしたらトップページに戻る
  def destroy
    log_out
    redirect_to( root_url )
  end

end
