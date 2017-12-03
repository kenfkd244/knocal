class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @questions = Question.all.order("created_at DESC")
    respond_to do |f|
      f.html
      f.json { render json: @questions }
    end
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

    address = URI.encode(current_user.postnumber)
    reqUrl = "http://maps.google.com/maps/api/geocode/json?address=#{address}&sensor=false&language=ja"
    response = Net::HTTP.get_response(URI.parse(reqUrl))

    case response
    when Net::HTTPSuccess then
      data = JSON.parse(response.body)
      @question.lat = data['results'][0]['geometry']['location']['lat']
      @question.lng = data['results'][0]['geometry']['location']['lng']
    end

    if @question.save
      redirect_to root_path, notice: "質問できました！"
    else
      redirect_to new_question_path(@question), alert: "項目漏れがあります..."
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    if question.user_id == current_user.id
      if question.update(question_params)
        redirect_to root_path, notice: "編集できました！"
      else
        redirect_to edit_question_path(question), alert: "項目漏れがあります..."
      end
    end
  end

  def destroy
    question = Question.find(params[:id])
    if question.user_id == current_user.id
      question.destroy
      redirect_to root_path, notice: "削除できました"
    end
  end

  private
  def question_params
    params.require(:question).permit(:content, :title)
  end
end
