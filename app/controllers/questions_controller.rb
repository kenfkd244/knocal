class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.all.order("created_at DESC")
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order("created_at DESC")
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to root_path, notice: "質問できました！"
    else
      redirect_to new_question_path(@question), alert: "Oh, my god"
    end
  end

  private
  def question_params
    params.require(:question).permit(:content, :title)
  end
end
