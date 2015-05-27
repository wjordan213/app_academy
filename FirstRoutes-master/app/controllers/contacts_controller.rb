class ContactsController < ApplicationController

  def index
    contacts = User.find(params[:user_id]).contacts
    render json: contacts
  end

  def create
    contact = Contact.new(params[:contact].permit(:name, :email, :user_id))
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(params[:contact].permit(:name, :email, :user_id))
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    user = Contact.find(params[:id])
    render json: user
  end

  def destroy
    contact = Contact.find(params[:id])
    if Contact.find(params[:id]).destroy
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

end
