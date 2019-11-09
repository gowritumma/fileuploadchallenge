require 'open-uri'
class UploadTxtfileJob < ApplicationJob
  discard_on ActiveJob::DeserializationError
  queue_as :default
  around_perform :around_uploading

  def perform(upload_id)
    # Do something later
    filename = Upload.find(upload_id).url
    states = State.all
    f = open(filename)
    f.each_line do |line|
    # You might be able to use split or something to get attributes
    attrs = line.split('|')
    puts attrs[0]
	County.create!(zip: attrs[0][0..6], name: attrs[0][10..-1], state_id: states.find_by_abbr(attrs[1]).id, city: attrs[2].strip)
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
