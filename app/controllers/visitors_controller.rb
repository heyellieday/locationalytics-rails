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

  def first_time
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visitor.joins(:visits).where("visitor.visits.count" == 1).order("end_time DESC"), :callback => params[:callback] }
	  	end
	else
		render json:  Visitor.joins(:visits).where("visitor.visits.count" == 1).order("end_time DESC")
	end
  end
  def all_lengths
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visit.select("length").where.not(length:nil).order("end_time DESC"), :callback => params[:callback] }
	  	end
	else
		render json: Visit.select("length").where.not(length:nil).order("end_time DESC")
	end
  end
  def length_by_store
    store_id = params[:store_id]
    if store_id == 1
      store_id = 2
    else
      store_id = 1
    end
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visit.where.not(length:nil, location:store_id).order("end_time DESC") , location: store_id, :callback => params[:callback] }
	  	end
	else
		render json: Visit.where.not(length:nil, location:store_id).order("end_time DESC")
	end
end
  def people_count_by_store
    store_id = params[:store_id]
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visit.where(location:store_id).order("end_time DESC"), location: store_id, :callback => params[:callback] }
	  	end
	else
		render json: Visit.where(location:store_id).order("end_time DESC")
	end
end
  def current_count_by_store
   store_id = params[:store_id]
  	params.permit(:callback)
  	if params[:callback]
  		respond_to do |format|
  			#format.html { render json: {stories: Story.all}}
	  		format.js { render json: Visit.where(end_time:nil, location:store_id).order("end_time DESC").count, location: store_id, :callback => params[:callback] }
	  	end
	else
		render json: Visit.where(end_time:nil, location:store_id).order("end_time DESC").count
	end
end

 
  def update
  	# This is where we would make the api call to the API which on initial time, 
  	# would populate the database with the current data.
  	# We will set a cron job using the whenever job to submit a patch request every X minutes
  	# In addition, the client can possibliy submit a request to get the most up to date info
  end
end
