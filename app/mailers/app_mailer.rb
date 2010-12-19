class AppMailer < ActionMailer::Base
  def contact_form(sender)
    @sender = sender
    mail( :to => sender.to,
          :from => sender.from, #this doesnt seem to work, gets the "name" part but email replaced by my gmail account email
          :subject => "#{APP_CONFIG[:app_name]} contact form"
    )
  end
  
end
