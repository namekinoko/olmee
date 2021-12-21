class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

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
      log_in( @user )
      flash[:success] = "ユーザー登録に成功しました。"
      redirect_to( services_path )
    else
      flash[:danger] = @user.errors.full_messages
      render 'new'
    end
  end

  # ユーザーのプロフィールページへ
  def edit 
    @user = User.find( params[:id] )
  end

  def update
    @user = User.find( params[:id] )
    if @user.update( user_params )
      flash[:success] = "編集に成功しました"
      redirect_to( @user )
    else
      render 'edit'
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

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end

end
