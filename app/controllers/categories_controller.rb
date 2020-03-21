class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name, :post_ids => [], :post_attributes => [:title, :content])
  end
end
