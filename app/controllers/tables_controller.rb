class TablesController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @tables = User.all
    render json: @tables
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # params[:id] is device id
    @table = User.find_by(device: params[:id])
    render json: @table
  end

  # POST /users
  # POST /users.json
  def create
    create_params = JSON.parse(request.raw_post)
    @table = User.new(create_params)
    if @table.save
      render json: @table
    else
      render json: {errors: @table.errors}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @table = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :device)
    end

end
