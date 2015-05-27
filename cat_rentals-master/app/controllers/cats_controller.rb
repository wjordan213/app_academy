class CatsController < ApplicationController
  before_action :user_owns_cat?, only: [ :edit, :update, :destroy ]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    if logged_in?
      @cat = Cat.find(params[:id])
      @approved_requests = @cat.cat_rental_requests.where("status = 'APPROVED'").order('start_date')
      @pending_requests = @cat.cat_rental_requests.where("status = 'PENDING'").order('start_date')
      render :show
    else
      redirect_to session_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    cat = Cat.new(cat_params)
    cat.user_id = current_user.id
    if cat.save
      redirect_to cat_url(cat.id)
    else
      # @attributes = cat_params
      render :new
    end
  end

  def update
    cat = Cat.find(params[:id])
    cat.update(cat_params)
    redirect_to cat_url(cat)
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def destroy
    Cat.find(params[:id]).destroy
    redirect_to cats_url
  end

  private

  def cat_params
    params[:cat].permit(:birth_date, :description, :sex, :name, :color)
  end

  def user_owns_cat?
    redirect_to cat_url(params[:id]) unless Cat.find(params[:id]).user_id == current_user.id
  end
end
