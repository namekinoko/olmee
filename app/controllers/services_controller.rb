class ServicesController < ApplicationController
  before_action :logged_in_user, only: [:index]
  
  def index
    if params[:keyword] != nil
      @groups = Group.where( prefecture: params[:keyword] ).page( params[:page] ).per( 9 )
    else
      @groups = Group.all.page( params[:page] ).per( 9 ).order( id: 'DESC' )
    end
  end

  def show
  end

end
