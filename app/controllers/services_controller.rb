class ServicesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    @posts = Post.all
  end

  def show
  end

end
