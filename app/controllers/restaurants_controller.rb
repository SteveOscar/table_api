class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:update, :destroy]

  def index
    @restaurants = Restaurant.all
    render json: @restaurants
  end

  def show
    # params[:id] is device id
    @restaurant = Restaurant.find_by(device: params[:id])
    render json: @restaurant
  end

  def create
    payload = restaurant_params.to_h
    binding.pry
    restaurant = Restaurant.new(payload)
    if restaurant.save
      render json: restaurant
    else
      render json: {errors: @restaurant.errors}, status: :unprocessable_entity
    end
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:uid, :email, :genre, :location, :name, :website, :menu, :zip, :verified)
    end

end
