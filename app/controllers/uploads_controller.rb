
require 'open-uri'

class UploadsController < ApplicationController
 def new
 end

 def create
    # Make an object in your bucket for your upload
    puts params[:file].original_filename
    obj = S3_BUCKET.object(params[:file].original_filename)
    puts params[:file].original_filename
    # Upload the file to S3
    obj.upload_file(params[:file].path)
    # Create an object for the upload
    puts "after uploading to S3"

    @upload = Upload.new(
    	url: obj.public_url,
		filename: params[:file].original_filename,
		user_id: current_user.id,
		processed: obj.public_url ? true : false,
		status: 0
    	)
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
	  @uploads = Upload.joins(:user).includes(:user)
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
