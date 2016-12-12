class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_followed_user, except: [:index, :destroy]

  def create
    current_user.follow @user
    redirect_to :back
  end

  def destroy
    @user = Relationship.find_by(params[:id]).followed
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
    current_user.unfollow @user
    redirect_to :back
  end

  def show
  end

  private
  def load_followed_user
    @user = User.find_by id: params[:followed_id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end
end
