class JsController < ApplicationController

  def jquery

  end

  def ajax1
    respond_to do |format|
      format.json { render json: {"msg"=>params} }
    end
  end

end
