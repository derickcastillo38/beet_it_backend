class Api::V1::CuisinesController < ApplicationController
  before_action :find_cuisine, only: [:show, :update, :delete]

  def index
    @cuisines = Cuisine.all
    render json: @cuisines
  end

  def show
    render json: @cuisine, status: 200

  end

  def create
    @cuisine = Cuisine.new(cuisine_params(:name))
    if @cuisine.save
      @recipeCard = RecipeCard.new(cuisine_params(:image, :title, :instructions, :ingredients, :mealtime_id).merge({:cuisine_id => @cuisine.id}))
      if @recipeCard.save
        render json: @recipeCard, status: 201
      else
        render json: { errors: @recipeCard.errors.full_messages }, status: :unprocessible_entity
      end
    else
      render json: { errors: @cuisine.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def cuisine_params(*args)
    params.permit(*args)
  end

  def find_cuisine
    @cuisine = Cuisine.find(params[:id])
  end
end


# #fetch('url', {
#   method: 'post',
#   headers: ...,
#   body: stringify {
#       id:
#       spice:
#   }
# })
