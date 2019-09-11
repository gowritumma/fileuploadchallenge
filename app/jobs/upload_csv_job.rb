require 'csv'
require 'open-uri'
class UploadCsvJob < ApplicationJob
  discard_on ActiveJob::DeserializationError
  queue_as :default
  around_perform :around_uploading

  def perform(upload_id)
    # read the columns in the csv file to check if it is state data or county
    url = Upload.find(upload_id).url
	columns = CSV.parse(open(url), headers: true).headers
	columns.pop while columns.last.nil?
	puts columns.count
	if columns.count == 2
    open(url) do |f|
    f.each_line do |l|
      CSV.parse(l) do |row|
        State.create!(abbr: row[0], name: row[1])
      end
    end
    end
		
	else
		states = State.all
    open(url) do |f|
    f.each_line do |l|
      CSV.parse(l) do |row|
        State.create!(zip: row[0], name: row[1], state_id: states.find_by_name(row[2]).id, city: row[3])
      end
    end
    end
		
	end
  end

   private
    def around_uploading
      # update the uploads table as in process 0 - not processed, 1 - processed, 2 - in process
      puts "before yield"
      upload = Upload.find(self.arguments.first)
      upload.update_attributes(:status => 2)
      yield
      # update the uploads table as done
      puts "after yield"
      upload.update_attributes(:status => 1)
      puts "after updating status to 1"
      # send a notification email to user
      # UserMailer.with(filename: upload.filename).fileupload_confirmation.deliver_later
      puts "after sending email"

    end

end
