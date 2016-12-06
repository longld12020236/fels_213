class Admin::UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update, :destroy]
  before_action :admin_verify

  def index
    @users = User.alphabet.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "deleted_user"
    else
      flash[:danger] = t "unsuccess_delete"
    end
    redirect_to admin_users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :is_admin, :name, :email, :password,
      :password_confirmation
  end
end
