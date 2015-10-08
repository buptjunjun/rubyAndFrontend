class RailstestController < ApplicationController

  def index

  end

  def upload
    puts params.inspect

    redirect_to :action => :index
  end

end
