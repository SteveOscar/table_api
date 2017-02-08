class TablesController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  def nearby_tables
    tables = Table.all.map{|t| t.food.to_s }
    render json: tables
  end

  # GET /tables/1
  # GET /tables/1.json
  def show
    # params[:id] is device id
    @table = Table.find_by(device: params[:id])
    render json: @table
  end

  # POST /tables
  # POST /tables.json
  def create
    create_params = JSON.parse(request.raw_post)
    @table = Table.new(create_params)
    if @table.save
      render json: @table
    else
      render json: {errors: @table.errors}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @table = Table.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:uid, :name, :email, :device)
    end

end
