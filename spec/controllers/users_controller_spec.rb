require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do
  render_views
  
  before :each do
    @user = User.make 
    User.stub(:new).and_return(@user)
    @mailer = mock(UserMailer)
    @mailer.stub(:deliver)
    UserMailer.stub(:welcome_email).and_return(@mailer)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    #User.any_instance.stubs(:valid?).returns(false)
    @user.should_receive(:save).and_return(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    #User.any_instance.stubs(:valid?).returns(true)
    @user.should_receive(:save).and_return(true)
    post :create
    response.should redirect_to("/dashboard")
  end
end
