class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    if @answer.save
      redirect_to root_path, method: :get, success: "Success!"
    else
      redirect_to new_question_answer_path(@question), method: :get, alert: "Oh, my god!"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
