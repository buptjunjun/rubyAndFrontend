class JsController < ApplicationController

  def jquery

  end

  def ajax1
    #sleep(1)
    respond_to do |format|
      format.json { render json: {"msg"=>params} }
    end
  end

end
