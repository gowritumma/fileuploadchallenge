class UserMailer < ActionMailer::Base
    default :from => "me@mydomain.com"

 def fileupload_confirmation(filename)
    mail(:to => "#{current_user.username} <#{current_user.email}>", :subject => "File upload Status.", :filename => filename)
 end

end