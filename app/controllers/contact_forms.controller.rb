class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end
  
  def create
    @contact_form = ContactForm.new(params[:contact_form])
    if @contact_form.save
      redirect_to root_url, :notice => "Message sent! Thank you for contacting us."
    else
      render :action => 'new'
    end
  end
end