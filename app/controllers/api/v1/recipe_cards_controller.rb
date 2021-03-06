class Api::V1::RecipeCardsController < ApplicationController
  before_action :find_recipe_card, only: [:show, :update, :destroy]

  def index
    @recipe_cards = RecipeCard.all
    render json: @recipe_cards
  end

  def show
    render json: @recipe_card, status: 200, scope: {'recipe': true}
  end

  def create
    @recipe_card = RecipeCard.new(recipe_card_params)

    @recipe_card.ingredients = params[:ingredients].split(";")
    @recipe_card.instructions = params[:instructions].split(";")

    if @recipe_card.save
      render json: @recipe_card, status: :accepted
    else
      render json: { errors: @recipe_card.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def update
    @recipe_card.update
    if @recipe_card.save
      render json: @recipe_card, status: :accepted
    else
      render json: { errors: @recipe_card.error.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @recipe_card.destroy
    if @recipe_card.destroyed?
      render json: @recipe_card, status: 204
    else
      render json: { errors: @recipe_card.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def recipe_card_params
    params.permit(:image, :title, :cuisine_id, :mealtime_id)
  end

  def find_recipe_card
    @recipe_card = RecipeCard.find(params[:id])
  end


end
