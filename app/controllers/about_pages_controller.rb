# frozen_string_literal: true

# Controller for managing about pages
class AboutPagesController < ApplicationController
  def show
    @about_page = AboutPage.find(params[:id])
  end
end
