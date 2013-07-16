class StopsController < ApplicationController

  # GET /stops/1.json
  def show
    @stop = Stop.find(params[:id])

    respond_to do |format|
      format.json { render json: @stop.to_json(include: :routes) }
    end
  end
  
end
