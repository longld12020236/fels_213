module UsersHelper
  def error_message content
    @user.errors.full_messages_for(content).join(", ") if @user.errors.has_key?(content)
  end
end
