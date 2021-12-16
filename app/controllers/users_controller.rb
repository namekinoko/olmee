class UsersController < ApplicationController

  def index
    redirect_to( new_user_path )
  end
  
  def show
    @user = User.find( params[:id] )
  end

  def new
    @user = User.new
  end

  # 新規登録成功時はDBに保存して、showページに飛ぶ。失敗時は新規登録ページにリダイレクトする。
  def create
    @user = User.new( user_params )
    if @user.save
      flash[:success] = "ユーザー登録に成功しました。"
      redirect_to( @user )
    else
      flash[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  private
    def user_params
      params.require( :user ).permit( 
        :name,
        :email,
        :nickname,
        :password,
        :password_confirmation
       )
    end

end
