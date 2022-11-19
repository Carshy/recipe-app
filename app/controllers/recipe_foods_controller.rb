class RecipeFoodsController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food.recipe_id = @recipe.id

    if @recipe_food.save
      flash[:success] = 'Food added successfully'
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = 'Error: Food could not be added'
      redirect_to new_recipe_recipe_food_path(@recipe)
    end
  end

  def destroy
    RecipeFood.find(params[:id]).destroy
    redirect_to recipe_path
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
