class GroupsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    redirect_to( new_group_path )
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create 
    @group = current_user.groups.build( group_params ) 
    if @group.save
      flash[:success] = "募集を開始しました"
      redirect_to( services_url )
    else
      render  'new'
    end
  end

  def destroy
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
end
