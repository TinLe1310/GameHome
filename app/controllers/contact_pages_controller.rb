class ContactPagesController < ApplicationController
  def show
    @contact_page = ContactPage.find(params[:id])
  end
end
