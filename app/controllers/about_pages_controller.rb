class AboutPagesController < ApplicationController
  def show
    @about_page = AboutPage.find(params[:id])
  end
end
