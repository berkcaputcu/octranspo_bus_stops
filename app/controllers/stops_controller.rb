class StopsController < ApplicationController

  # GET /stops/1.json
  def show
  	@stop = Stop.find(params[:id])

  	respond_to do |format|
  		format.json { render json: @stop.to_json(include: :routes) }
  	end
  end

  def search
  	@stop = Stop.find_by_code(params[:stop_code])

  	respond_to do |format|
  		format.json { render json: @stop.to_json(only: :id) }
  	end
  end
  
end
