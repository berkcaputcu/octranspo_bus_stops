class StopsController < ApplicationController

  # GET /stops/1
  # GET /stops/1.json
  def show
    @stop = Stop.find(params[:id])

    respond_to do |format|
      format.json { render json: @stop }
    end
  end
  
end
