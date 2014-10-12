class VisitorsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
	  		format.js { render json: {visitors: Visitor.response}, :callback => params[:callback] }
	  	end
  	else
  		render json: {visitors: Visitor.response}
  	end
  end

  def show
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visitor.find_by(id: params[:id]), :callback => params[:callback] }
	  	end
	else
		render json: Visitor.all
	end
  end
  def show
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visitor.find_by(id: params[:id]), :callback => params[:callback] }
	  	end
	else
		render json: Visitor.all
	end
  end
  def update
  	# This is where we would make the api call to the API which on initial time, 
  	# would populate the database with the current data.
  	# We will set a cron job using the whenever job to submit a patch request every X minutes
  	# In addition, the client can possibliy submit a request to get the most up to date info
  end
end
