class ChatsController < ApplicationController
  # @messageで新規メッセージ作成用の空のインスタンス変数作成
  # @chatsでグループチャットの過去ログを取得
  # @groupでチャットするグループを取得
  def index
    @message = current_user.chats.new
    @group = Group.find( params[:group_id] )
    @chats = @group.chats
  end

  # グループのメッセージの新規作成
  # 作成時、json形式を作り、chat.jsでメッセージの非同期処理を行なっている
  def create
    @group = Group.find( params[:group_id] )
    @message = current_user.chats.new( chat_params )
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_chats_path( @group ) }
        format.json { render json: { "new_chat" => @message,
                                     "current_user_id" => current_user.id,
                                     "current_user_nickname" => current_user.nickname
                                    } 
                    }
      end
    else
      redirect_to group_chats_path( @group )
    end
  end

  private
    # ストロングパラメーター
    def chat_params
      params.require( :chat ).permit( 
        :message,
        :group_id
      )
    end

end
