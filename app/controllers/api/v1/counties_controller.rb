class Api::V1::CountiesController < Api::V1::BaseController

# returns count of counties, cities and zip codes
	# params => abbr 
 	# param :header, 'X-USER-TOKEN', :string, :required, 'Authentication token'
    # param :header, 'X-USER-LOGIN', :string, :required, 'User Login/username'
def get_counties_states_abbr
	#select count(distinct(name)) as county, count(distinct(city)) as city, count(distinct(zip)) as zips from counties where state_id = 313;
	state = State.find_by_abbr(params[:abbr])
	puts state.id
	puts state.name
	@counties = County.select('count(distinct(name)) as county, count(distinct(city)) as city, count(distinct(zip)) as zips').where('state_id = ?', state.id)
	render json: @counties

end

# return the county , state and city
# params => zip 
def get_counties_with_zip
@county = County.joins(:state).select('counties.zip, counties.name as county_name, counties.city, states.name as state_name').where('counties.zip = ?', params[:zip])
render json: @county
end

# def index
# 	puts "in counties controller"
# 	@counties = County.all
# 	render json: @counties
# end

end
