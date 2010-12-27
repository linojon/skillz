require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before :each do
    @geo = mock( :provider => 'google', :city => 'Lisbon', :state => 'NH', :zip => '03585', :lat => 44.2179603, :lng => -71.7760429, :country => 'USA', :success => true )
    MultiGeocoder.stub(:geocode).and_return(@geo)
  end
  
  it "should be valid without password" do
    user = User.new( :email => 'example@example.com', :zipcode => '03585')
    user.should be_valid
    user.save.should be_true
  end
  
  it "should require email" do
    user = User.new( :zipcode => '12345')
    user.should_not be_valid
  end
  
  it "should require zipcode" do
    user = User.new( :email => 'example@example.com')
    user.should_not be_valid
  end
  
  it "should require password on update (progressive engagement)" do
    # User.create fails however, not sure why
    user = User.new( :email => 'example@example.com', :zipcode => '03585')
    user.should be_valid
    user.save.should be_true
    user.update_attributes(:password => 'secret', :password_confirmation => 'secret')
    user.should be_valid
    user.save.should be_true
  end
  
  it "should not be registered when no password defined" do
    user = User.new( :email => 'example@example.com', :zipcode => '03585')
    user.save
    user.registered?.should_not be_true
  end
  
  it "should be registered when password defined" do
    user = User.new( :email => 'example@example.com', :zipcode => '03585',:password => 'secret', :password_confirmation => 'secret')
    user.save
    user.registered?.should be_true
  end
    
  it "should act as mappable" do
    User.should respond_to( :find_within)
  end
  
  it "should convert zipcode to lat,lng when validating zipcode" do
    MultiGeocoder.should_receive(:geocode).with('03585').and_return(@geo)
    user = User.new( :email => 'example@example.com', :zipcode => '03585')
    user.should be_valid
    user.lat.should == @geo.lat
    user.lng.should == @geo.lng
  end
  
  it "should validate zipcode format" do
    user = User.new( :email => 'example@example.com', :zipcode => '00A00')
    user.should_not be_valid
    user.errors[:zipcode].should include('is an invalid zip code')
  end
  
  it "should validate zipcode is valid" do
    @geo.stub(:success).and_return(false)
    user = User.new( :email => 'example@example.com', :zipcode => '03585')
    user.should_not be_valid
    user.errors[:zipcode].should include('is not a valid US zip code')
  end
  
    
end

# res=MultiGeocoder.geocode('03585')
#  => Provider: google
# Street: 
# City: Lisbon
# State: NH
# Zip: 03585
# Latitude: 44.2179603
# Longitude: -71.7760429
# Country: US
# Success: true 
# ruby-1.9.2-p0 :005 > p res.success
# true
# 
# > p res.to_yaml
# "--- &id001 !ruby/object:Geokit::GeoLoc 
# accuracy: 5
# all: 
# - *id001
# city: Lisbon
# country: USA
# country_code: US
# district: Landaff
# full_address: Lisbon, NH 03585, USA
# lat: 44.2179603
# lng: -71.7760429
# precision: zip
# provider: google
# province: 
# state: NH
# street_address: 
# success: true
# suggested_bounds: !ruby/object:Geokit::Bounds 
#   ne: !ruby/object:Geokit::LatLng 
#       lat: 44.314682
#       lng: -71.7681889
#   sw: !ruby/object:Geokit::LatLng 
#       lat: 44.1003909
#       lng: -72.0188989
# zip: 03585
# "
