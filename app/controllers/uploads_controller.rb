
require 'open-uri'

class UploadsController < ApplicationController
 def new
 end

 def create
    # Make an object in your bucket for your upload
    obj = S3_BUCKET.object(params[:uploads][:file].original_filename)
    # Upload the file to S3
    obj.upload_file(params[:uploads][:file].path)
    # Create an object for the upload

    @upload = Upload.new(
    	url: obj.public_url,
		filename: params[:uploads][:file].original_filename,
		user_id: current_user.id,
		processed: obj.public_url ? true : false,
		status: 0
    	)
    # Save the upload
    if @upload.save
	  	filename = params[:uploads][:file].path
	  	file_ext = filename.split('.').pop
	  	case file_ext
	  		when "csv"
	  		UploadCsvJob.perform_later(@upload.id, filename)
	  		# process_csv_file (filename)
	  		when "txt"
	  		UploadTxtfileJob.perform_later(@upload.id, filename)
	  		# process_txt_file (filename)
	  		else
	  		flash.now[:notice] = 'File format not accepted'
	        render :new
	  	end
	  	flash.now[:notice] = 'File saved to S3 bucket successfully'
	    
    else
      flash.now[:notice] = 'There was an error'
    end
    @uploads = Upload.all
    
 end

def index
	  @uploads = Upload.all
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
