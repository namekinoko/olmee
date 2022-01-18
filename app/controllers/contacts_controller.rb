class ContactsController < ApplicationController

  def index
    redirect_to new_contact_path
  end
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new( contact_params )
    if @contact.save
      ContactMailer.contact_mail( @contact ).deliver
      redirect_to main_service_path
    else
      render new_contact_path
    end
  end

  private
    def contact_params
      params.require( :contact ).permit( 
        :name,
        :email,
        :subject,
        :message
      )
    end

    

end
