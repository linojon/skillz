require "spec_helper"

describe UserMailer do
  describe "Welcome email" do
    before :each do
      @user = User.make( :email => 'foo@example.com')
      @mail = UserMailer.welcome_email(@user)
    end
    
    it "should deliver to the users email" do
      @mail.should deliver_to('foo@example.com')
    end
    
    it "should contain a signin link in the body" do
      @mail.should have_body_text( /http:\/\/www.appname.com\/signin/ )
    end
    
    it "should have Welcome subject" do
      @mail.should have_subject(/Welcome to AppName/)
    end
  end
end
