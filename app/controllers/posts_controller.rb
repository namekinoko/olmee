class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    redirect_to( new_post_path )
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create 
    @post = current_user.posts.build( post_params ) 
    if @post.save
      flash[:success] = "投稿に成功しました"
      redirect_to( services_url )
    else
      render  'new'
    end
  end

  def destroy
  end

  private
    def post_params
      params.require( :post ).permit(
        :date,
        :prefecture,
        :municipality,
        :content,
        :number
      )
    end
end
