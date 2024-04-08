class AboutPagesController < ApplicationController
  def show
    @about = AboutPage.find(params[:id])
  end
end
