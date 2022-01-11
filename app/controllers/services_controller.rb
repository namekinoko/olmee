class ServicesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    @groups = Group.all
  end

  def show
  end

end
