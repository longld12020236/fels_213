class UsersController < ApplicationController
  before_action :logged_in_user, except: :new

  def index
     @users = User.alphabet.paginate page: params[:page],
        per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("home_page.intro")
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
