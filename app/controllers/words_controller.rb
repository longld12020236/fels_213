class WordsController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.all
    @word_variable  = Word.create_word_variable(params[:condition],
      params[:search_word], params[:category_id], current_user.id)
    @words = @word_variable.paginate page: params[:page],
      per_page: Settings.per_page
  end
end
