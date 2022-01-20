class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:create, :join]
  before_action :confirmation_correct_user, only: [:update, :edit, :destroy]

  def index
    redirect_to( new_group_path )
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find( params[:id] )
  end

  # 募集内容（グループ）の詳細ページ
  def show
    @group = Group.find( params[:id] )
  end

  # 募集（グループ）作成
  def create 
    @group = Group.new( group_params ) 
    @group.user_id = current_user.id
    @group.users << current_user
    if @group.save
      flash[:success] = "募集を開始しました"
      redirect_to( services_url )
    else
      render  'new'
    end
  end

  # 募集内容（グループ）の削除
  def destroy
    group = Group.find_by(id: params[:id])
    group.destroy
    flash[:success] = "募集を取り消しました"
    redirect_to( services_url )
  end

  # 募集内容（グループ）の変更
  def update
    if @group.update( group_params )
      flash[:success] = "募集内容を変更しました"
      redirect_to( services_url )
    else
      render "edit"
    end
  end

  # グループに参加する処理 
  def join
    @group = Group.find_by(id: params[:id])
    if !@group.users.include?( current_user )
      @group.users << current_user
      flash[:success] = "募集に参加しました"
      if ( request.referer&.include?( '/services' ) )
        redirect_to( services_url )
      else
        redirect_to  group_path( @group )
      end
    end
  end

  # グループ参加を取り消す処理
  def cancel
    @group = Group.find_by( id: params[:id] )
    @group.users.delete( current_user )
    flash[:success] = "参加を取り消しました"
    if ( request.referer&.include?( '/services' ) )
      redirect_to( services_url )
    else
      redirect_to  group_path( @group )
    end
  end

  private
    def group_params
      params.require( :group ).permit(
        :date,
        :prefecture,
        :municipality,
        :purpose,
        :content,
        :number
      )
    end
    
    def confirmation_correct_user
      @group = Group.find( params[:id] )
      unless @group.user_id == current_user.id
        redirect_to( services_url )
      end
    end

end
