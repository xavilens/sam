module UsersHelper
  def is_current_user?
    @user.id == current_user.id
  end

end
