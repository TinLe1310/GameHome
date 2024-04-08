class ContactPagesController < ApplicationController
  def show
    @contact = ContactPage.find(params[:id])
  end
end
