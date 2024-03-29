class CategoriesController < ApplicationController

  load_and_authorize_resource
  before_filter :set_current_category, only: [:show, :edit, :update, :destroy]

  include ActivationHelper

  # --------- before filter methods -------- #
  def set_current_category
    @category = Category.find(params[:id])
  end
  # --------- end before filter methods -------- #

  def index
    if (params[:show_deleted])
      @categories = Category.all
    else
      @categories = Category.active
    end
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Successfully created category."
      redirect_to @category
    else
      flash[:error] = "Oops! Something went wrong with creating the category."
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:notice] = "Successfully updated category."
      redirect_to @category
    else
      render action: 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :max_per_user, :max_checkout_length,
                                     :deleted_at, :max_renewal_times, :max_renewal_length,
                                     :renewal_days_before_due, :sort_order)
  end

end
