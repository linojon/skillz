class UserMailer < ActionMailer::Base
  default :from => APP_CONFIG[:admin_email]
  default_url_options[:host] = APP_CONFIG[:host]
  
  # links need to provide full url: user_url(@user)
  
  
  def welcome_email(user)
    @user = user
    @url = APP_CONFIG[:app_url] + '/signin'
    @app_name = APP_CONFIG[:app_name]
    mail( :to => user.email,
          :subject => "Welcome to #{@app_name}"
    )
  end
  
  def password_reset_instructions(user)
    @user = user
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail( :to => user.email,
          :subject => "Password Reset Instructions"
    )
  end
end
