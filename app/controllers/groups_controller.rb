class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :confirmation_correct_user, only: [:update, :edit]
  def index
    redirect_to( new_group_path )
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find( params[:id] )
  end

  def show
    @group = Group.find( params[:id] )
  end

  def create 
    @group = current_user.groups.build( group_params ) 
    @group.users << current_user
    if @group.save
      flash[:success] = "募集を開始しました"
      redirect_to( services_url )
    else
      render  'new'
    end
  end

  def destroy
  end

  def update
    if @group.update( group_params )
      flash[:success] = "募集内容を変更しました"
      redirect_to( services_url )
    else
      render "edit"
    end
  end

  

  private
    def group_params
      params.require( :group ).permit(
        :date,
        :prefecture,
        :municipality,
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
