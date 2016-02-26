class RailstestController < ApplicationController

  def index

  end

  def upload
    puts params.inspect

    file =  params[:myupload][:file]
    redirect_to :action => :index
  end

  def create_patients

  end

end
