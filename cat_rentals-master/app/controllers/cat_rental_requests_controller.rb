class CatRentalRequestsController < ApplicationController
  before_action :user_owns_cat?, only: [ :approve, :deny ]
  before_action :is_logged_in?, only: [ :new ]

  def is_logged_in?
    redirect_to cats_url unless logged_in?
  end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    @cat_rental_request.user_id = current_user.id
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @cats = Cat.all
      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    request = CatRentalRequest.find(params[:id])
    request.update!(:status => 'DENIED')
    redirect_to cat_url(request.cat_id)
  end

  def approve
    request = CatRentalRequest.find(params[:id])
    request.update!(:status => 'APPROVED')
    redirect_to cat_url(request.cat_id)
  end

  private

  def request_params
    params[:cat_rental_request].permit(:start_date, :end_date, :cat_id)
  end

  def user_owns_cat?
    request = CatRentalRequest.find(params[:id])
    cat = Cat.find(request.cat_id)
    redirect_to cat_url(request.cat_id) unless cat.user_id == current_user.id
  end
end
