class HomeController < ApplicationController

  def index
    @page = params[:page]
  end

end
