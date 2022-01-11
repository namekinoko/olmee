module GroupsHelper

  def user_joined_group?( user, group )
    group.users.include?( user )
  end
  
end
