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
      redirect_to root_path, method: :get, notice: "回答できました！"
    else
      redirect_to new_question_answer_path(@question), method: :get, alert: "項目漏れがあります..."
    end
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:id])
    if answer.user_id == current_user.id
      if answer.update(answer_params)
        redirect_to root_path, notice: "編集できました！"
      else
        redirect_to edit_question_answer_path(question, answer), alert: "項目漏れがあります..."
      end
    end
  end

  def destroy
    question = Question.find(params[:question_id])
    answer = Answer.find(params[:id])
    if answer.user_id == current_user.id
      answer.destroy
      redirect_to question_path(question), method: :get, notice: "削除できました"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:content)
  end
end
