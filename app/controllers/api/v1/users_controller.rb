class Api::V1::UsersController < Api::ApplicationController
  before_action :set_user, on: [:show]

  def show
    _success
  end

  def create_location
  end
  
private 
  def set_user
    @user = User.find(params[:id])
  end
end
