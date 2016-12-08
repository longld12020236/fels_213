class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :load_category, :admin_verify, except: [:index, :create, :new]

  def index
    @categories = Category.alphabet.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "create_category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
    @words = @category.words.alphabet.paginate page: params[:page],
      per_page: Settings.per_page
    session[:cat_id] = @category.id
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category_update"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "update_category_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category_delete"
    else
      flash[:danger] = t "unsuccess_delete"
    end
    redirect_to admin_categories_path
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "not_found_category"
      redirect_to admin_categories_path
    end
  end

  def category_params
    params.require(:category).permit :title
  end
end
