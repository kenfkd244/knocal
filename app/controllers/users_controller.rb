class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    current_user.update(user_params)
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :postnumber)
  end
end
