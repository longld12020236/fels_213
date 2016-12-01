module SessionsHelper

  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def current_user? user
    current_user == user
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
