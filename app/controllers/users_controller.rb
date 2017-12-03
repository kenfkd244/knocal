class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.order("created_at DESC")
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: "編集できました"
    else
      redirect_to edit_user_path(current_user), alert: "項目漏れがあります..."
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :postnumber)
  end
end
