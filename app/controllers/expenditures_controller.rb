class ExpendituresController < ApplicationController
  before_action :set_expenditure, only: %i[show destroy]

  # GET /expenditures or /expenditures.json
  def index
    @expenditures = Expenditure.all.order(created_at: :desc)
  end

  def show; end

  def new
    @expenditure = Expenditure.new
    @category = Category.find(params[:category_id])
  end

  def create
    @category = Category.find(params[:category_id])
    @expenditure = Expenditure.new(expenditure_params)
    @expenditure.author_id = current_user.id
    if @expenditure.save
      category_expenditure = CategoryExpenditure.new(category_id: params[:category_id], expenditure_id: @expenditure.id)
      category_expenditure.save
      redirect_to category_path(@category.id)
      flash[:notice] = 'Expenditure added'
    else
      render :new
      flash[:notice] = 'Error adding expenditure'
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @expenditure.destroy
    flash[:notice] = 'Expenditure deleted'
    redirect_to category_path(@category.id)
  end

  private

  def set_expenditure
    @expenditure = Expenditure.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def expenditure_params
    params.require(:expenditure).permit(:name, :amount)
  end
end
