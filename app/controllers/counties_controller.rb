class CountiesController < ApplicationController
  def search

  end

def get_results
	puts params[:search][:zip]
	@zip_flag = true
  	if params[:search][:abbr] != ''
  		puts "calling abbr method"
  		@zip_flag = false
  		@county = get_counties_states_abbr params[:search][:abbr]
  	else
  		puts " calling zip code method"
  		@county = get_counties_with_zip params[:search][:zip]
  	end
  	 respond_to do |format|
      format.js 
    end
end

def get_counties_states_abbr(abbr)
	#select count(distinct(name)) as county, count(distinct(city)) as city, count(distinct(zip)) as zips from counties where state_id = 313;
	puts "in get_counties_states_abbr"
	state = State.find_by_abbr(abbr)
	@counties = County.where('state_id = ?', state.id).pluck('count(distinct(name)) as county, count(distinct(city)) as city, count(distinct(zip)) as zips')
end

# return the county , state and city
# params => zip 
def get_counties_with_zip(zip)
	puts zip
	# User.where(id: 1).joins(:cards).includes(:cards)
	# @counties = County.joins(:state).pluck("counties.zip as zip, counties.name as county_name, counties.city as city, states.name as state_name").where("counties.zip = ?", zip)
	@counties = County.where("counties.zip = ?", zip).joins(:state).includes(:state).pluck("counties.zip as zip, counties.name as county_name, counties.city as city, states.name as state_name")
end

# gets the typed state name data
def search_state
  puts "in search state"
  @find = State.where('name LIKE ?', "%#{params[:q]}%")
  render json: @find
end

# renders the view with typehead for state names
def states_info
end

#get the list of counties for the selected state name
def get_counties_for_statename
  puts "in get_counties_for_statename"
  state_id = State.find_by_name(params[:name])
  puts state_id
  @counties = County.where("state_id = ?", state_id).joins(:state).includes(:state).pluck("counties.zip as zip, counties.name as county_name, counties.city as city, states.name as state_name")
   respond_to do |format|
        format.js
    end
  # render json: { html: render_to_string(partial: 'counties', locals: { counties: @counties } ) }  
end


end
