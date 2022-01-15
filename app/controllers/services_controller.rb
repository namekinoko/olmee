class ServicesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    if params[:keyword] != nil
      @groups = Group.where( prefecture: params[:keyword] )
    else
      @groups = Group.all.order( id: 'DESC' )
    end
  end

  def show
  end

end
