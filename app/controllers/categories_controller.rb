class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]

  def index
    @categories = Category.all.order(created_at: :desc)
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.author_id = current_user.id
    if @category.save
      flash[:notice] = 'Category was successfully created'
      redirect_to categories_path
    else
      flash[:notice] = 'Could not create category successfully'
      render :new
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = 'The category was successfully deleted'
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
