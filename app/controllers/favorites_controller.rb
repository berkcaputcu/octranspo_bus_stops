class FavoritesController < ApplicationController

	before_filter :authenticate_user!

	def index
		@favorites = current_user.favorites

		respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /favorites/1.json
  def show
  	@favorite = Favorite.find(params[:id])

  	respond_to do |format|
  		format.json { render json: @favorite }
  	end
  end

  # POST /favorites
  # POST /favorites.json
  def create
    if params[:stop_time_id].blank?
      redirect_to :root
      return
    end
    
    @stop_time = StopTime.find_by_id(params[:stop_time_id])
    @favorite = (@stop_time)? current_user.favorite(@stop_time) : nil

    respond_to do |format|
      if @favorite
        format.json { render json: @favorite, status: :created, location: @favorite }
      else
        format.json { render json: 'StopTime does not exist', status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorites
  # DELETE /favorites.json
  def destroy
    if params[:stop_time_id].blank?
      redirect_to :root
      return
    end

    @favorite = current_user.favorites.find_by_stop_time_id(params[:stop_time_id])
    @favorite.destroy if @favorite

    respond_to do |format|
      format.json { head :no_content }
    end
  end
  
end
