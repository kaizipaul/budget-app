class ExpendituresController < ApplicationController
  before_action :set_expenditure, only: %i[show destroy]

  # GET /expenditures or /expenditures.json
  def index
    @expenditures = Expenditure.all.order(created_at: :desc)
  end

  def show; end

  def new
    @expenditure = Expenditure.new
  end

  def create
    @expenditure = Expenditure.new(expenditure_params)
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
    @expenditure.destroy
    flash[:notice] = 'The category was successfully deleted'
    redirect_to categories_path
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
