class ChatsController < ApplicationController

  def index
    @chat = current_user.chats.new
    @group = Group.find( params[:group_id] )
    @chats = @group.chats
  end

  def create
    @group = Group.find( params[:group_id] )
    @message = current_user.chats.new( chat_params )

    if @message.save
      p 'succsessss'
      redirect_to group_chats_path( @group )
    else
      redirect_to services_path
      p '失敗'
      p @group.id
    end
  end

  private
    def chat_params
      params.require( :chat ).permit( 
        :message,
        :group_id
      )
    end

end
