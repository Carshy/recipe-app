# frozen_string_literal: true

class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  # def show
  #   @inventory = Inventory.find(params[:id])
  # end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      flash[:success] = 'Inventory added successfully'
      redirect_to inventories_path
    else
      flash.now[:error] = 'Error: Inventory could not be added'
      redirect_to new_inventory_path
    end
  end

  def destroy
    Inventory.find(params[:id]).delete
    redirect_to inventories_path
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :description)
  end
end
