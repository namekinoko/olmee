module ChatsHelper

  def user_name( chat )
    return User.find( chat.user_id ).nickname
  end
  
end
