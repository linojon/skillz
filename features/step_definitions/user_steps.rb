module UserHelpers
  def create_user(email = nil, zipcode='03585')
    email ||= 'example@example.com'
    #@current_user ||= User.make( :username => username )
    user = User.create(:email => email, :zipcode => zipcode, :password => 'secret', :password_confirmation => 'secret')
    @current_user ||= user
  end
  
  def create_unregistered_user(email = nil, zipcode='03585')
    email ||= 'example@example.com'
    user = User.create(:email => email, :zipcode => zipcode)
    @current_user ||= user
  end
  
  def create_admin
    create_user( 'admin@example.com')
    @current_user.admin = true
    @current_user.save
  end

  def signin_user( email=nil )
    visit "/signin"
    fill_in("Email", :with => (email || @current_user.email))
    fill_in("Password", :with => 'secret')
    click_button("Sign in")
  end

  def signout_user
    # session = UserSession.find
    # session.destroy if session
    visit "/signout"
  end

  def user_session
    @session ||= UserSession.find
  end
end
World(UserHelpers)

# authentication/session steps
# ref: https://github.com/mindtonic/AuthLogic-Cucumber-Steps/tree/master
# Activate AuthLogic prior to testing
require 'authlogic/test_case'
Before do
  include Authlogic::TestCase
  activate_authlogic
end


Given /^there is a user "(.*)"$/ do |email|
  create_user email
end

Given /^there is an unregistered user "(.*)"$/ do |email|
  create_unregistered_user email
end

Given /^I am signed in(?: as "([^"]*)")?$/ do |email| #"
  create_user email
  signin_user
end

Given /^I am signed in as an admin$/ do
  create_admin
  signin_user
end

Given /^I am not signed in$/ do
  signout_user
end

Given /^there are users registered$/ do
  User.make(:foo)
  User.make(:bar)
end

When /^I sign in(?: as "([^"]*)")?$/ do |email| #"
  signin_user email
end

When /^I sign out$/ do
  signout_user
end

Then /^there should be a session$/ do
  user_session
  @session.should_not be nil
end

Then /^there should not be a session$/ do
  user_session
  @session.should be nil
end

Then /^the user should be "([^"]*)"$/ do |email| #"
  user_session
  @session.user.email.should be == email
end

Then /^the user should not be registered$/ do
  user_session
  @session.user.should_not be_registered
end

Then /^the user should be registered$/ do
  user_session
  @session.user.should be_registered
end

# user profile steps

# user admin steps
