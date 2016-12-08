class Admin::WordsController < ApplicationController
  before_action :load_word, :admin_verify, except: [:index, :create, :new]
  before_action :load_category, except: [:show, :new]

  def index
    @categories = Category.all
    @word_variable  = Word.create_word_variable(params[:condition],
      params[:search_word], params[:category_id], current_user.id)
    @words = @word_variable.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @word = Word.new
    create_answer
  end

  def show
  end

  def create
    @word = @category.words.new word_params
    if @word.save
      flash[:success] = t "create_word_success"
      redirect_to admin_category_path session[:cat_id]
    else
      render :new
    end
  end

  def destroy
    if @word.present?
      @word.destroy
    end
    redirect_to :back
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
        flash[:success] = t("updated")
        redirect_to category_path session[:cat_id]
      else
        render :edit
      end
  end

  private
  def create_answer
    2.times{@word.answers.build}
  end

  def word_params
    params.require(:word).permit :content,
      answers_attributes: [:id, :content, :is_correct]
  end

  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "cant_found"
      redirect_to admin_categories_path
    end
  end

  def load_category
    @category = Category.find_by id: session[:cat_id]
    unless @category
      flash[:danger] = t("category_not_found")
      redirect_to admin_categories_path
    end
  end
end
