
require 'open-uri'

class UploadsController < ApplicationController
 def new
 	puts "in new method"
 end

 def create
 	puts "in create"
    # Make an object in your bucket for your upload

    obj = S3_BUCKET.object(params[:file].original_filename)
    puts "after obj"
    # Upload the file to S3
    obj.upload_file(params[:file].path)
    # Create an object for the upload
    puts "after obj"

    @upload = Upload.new(
    	url: obj.public_url,
		filename: params[:file].original_filename,
		user_id: current_user.id,
		processed: obj.public_url ? true : false,
		status: 0
    	)
    puts "after @upload object"
    # Save the upload
    puts "before saving the record"
    if @upload.save
	  	filename = params[:file].path
	  	file_ext = filename.split('.').pop
	  	case file_ext
	  		when "csv"
	  		UploadCsvJob.perform_later(@upload.id)
	  		# process_csv_file (filename)
	  		when "txt"
	  		UploadTxtfileJob.perform_later(@upload.id)
	  		# process_txt_file (filename)
	  		else
	  		flash.now[:notice] = 'File format not accepted'
	        render :new
	  	end
	  	flash.now[:notice] = 'File saved to S3 bucket successfully'
	    
    else
      flash.now[:notice] = 'There was an error'
    end
   	  @uploads = Upload.joins(:user).includes(:user)

    
 end

def index
	  @uploads = Upload.joins(:user).includes(:user).pluck("uploads.id as id, uploads.status as status, uploads.processed as processed, uploads.filename as filename, uploads.url as url, users.username as username, users.email as email")
end

def download 
	puts "in download method"
	url = Upload.find(params[:id]).url
	puts url
	extension = url.split('.').pop
	data = open(url)
	send_data data.read, :filename => "#{data.base_uri.to_s.split('/')[-1]}"
end


end
