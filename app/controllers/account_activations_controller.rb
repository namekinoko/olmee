class AccountActivationsController < ApplicationController

# 新規アカウント登録認証URLが開かれた際の処理
  def edit
    user = User.find_by( email: params[:email] )
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute( :activated, true )
      log_in( user )
      flash[:success] = "アカウントが有効になりました"
      redirect_to( '/services' )
    else
      flash[:danger] = "無効な認証リンクです"
      redirect_to( root_url )
    end
  end

end
