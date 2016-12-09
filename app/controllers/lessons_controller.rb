class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :load_lesson, only: [:edit, :update, :show]
  def show
    @results = @lesson.results
  end

  def edit
    @words = @lesson.words
  end

  def update
    if @lesson.words.any?
      if @lesson.update_attributes lesson_params
        flash[:success] = t "finish"
        redirect_to @lesson
      else
        render :edit
      end
    else
      flash[:danger] = t "not_word"
      redirect_to @lesson
    end
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.category.words.any?
      if @lesson.save
        flash[:success] = t "success_create"
        redirect_to edit_lesson_path @lesson
      else
        flash[:danger] = t "fail_create"
        redirect_to categories_path
      end
    else
      flash[:danger] = t "cannot_start"
      redirect_to categories_path
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, :result,
      results_attributes: [:id, :answer_id, :word_id]
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "not_found_lesson"
      redirect_to categories_path
    end
  end
end
