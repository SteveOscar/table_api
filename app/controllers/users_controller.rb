class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  # GET /users
  # GET /users.json
  def index
    binding.pry
    @users = User.all
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # params[:id] is device id
    @user = User.find_by(device: params[:id])
    render json: @user
  end

  # POST /users
  # POST /users.json
  def create
    payload = user_params
    payload[is_restauant] = false if !user_params.is_restaurant
    @user = User.new(payload)
    if @user.save
      render json: @user
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uid, :email, :location, :name, :is_restaurant, :genre, :website, :menu)
    end

end
