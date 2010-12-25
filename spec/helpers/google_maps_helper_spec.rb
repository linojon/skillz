require File.dirname(__FILE__) + '/../spec_helper'

describe GoogleMapsHelper do
  
  def google_map_scripts
    helper.instance_variable_get(:@google_map_scripts)
  end
  

  #---
  describe "google_map_render" do
    before :each do
      @options = { :lat => 100.1, :lng => 200.2 }
      helper.google_map_render(@options)
    end
    
    it "should initialize a google map" do
      google_map_scripts.should include('new google.maps.Map')
    end
    
    it "should default to zoom level 8" do
      google_map_scripts.should include('"zoom":8')
    end
    
    it "should set zoom level" do
      @html = helper.google_map_render(@options.merge(:zoom => 16))
      google_map_scripts.should include('"zoom":16')      
    end
    
    it "should set the center lat and lng" do
      google_map_scripts.should include('"center":new google.maps.LatLng(100.1, 200.2)')
    end
    
    it "should default to roadmap type" do
      google_map_scripts.should include('"mapTypeId":google.maps.MapTypeId.ROADMAP')
    end
    
    it "should set custom skillz map type" do
      @html = helper.google_map_render(@options.merge(:map_type => 'skillz'))
      
      google_map_scripts.should include('"mapTypeId":"skillz"')
      google_map_scripts.should include('[{"featureType":"all","stylers":[{"hue":"#0000ff"},{"saturation":-75}]},{"featureType":"poi","elementType":"label","stylers":[{"visibility":"off"}]}]')
      google_map_scripts.should include('new google.maps.StyledMapType(stylez, {name: "skillz"} )')
      google_map_scripts.should include('google_map.mapTypes.set("skillz", styledMapType)')
    end
    
    it "should set disable pan and zoom controls" do
      @html = helper.google_map_render(@options.merge(:pan_zoom => false))
      google_map_scripts.should include('"disableDefaultUI":true,"disableDoubleClickZoom":true,"draggable":false')      
    end
    
  end
  
  #---
  describe "google_map_marker" do
    before :each do
      @options = { :lat => 100.1, :lng => 200.2 }
      helper.instance_variable_set(:@google_map_scripts, '')
      helper.google_map_marker(@options)
    end
  
    it "should set the position lat and lng" do
      google_map_scripts.should include('"position":new google.maps.LatLng(100.1, 200.2)')
    end

    it "should default to flag1.png icon" do
      google_map_scripts.should include('"icon":"/images/flag1.png"')
    end

    it "should set icon" do
      helper.instance_variable_set(:@google_map_scripts, '')
      helper.google_map_marker(@options.merge(:icon => 'flag99.png'))
      google_map_scripts.should include('"icon":"/images/flag99.png"')
    end
    
  end
  
  #---
  describe "google_map_delay_load" do
    before :each do
      helper.instance_variable_set(:@google_map_scripts, 'stuff')
      helper.google_map_delay_load
    end
    
    it "should load the google maps API" do
      # spot check the expected javascript
      # helper appends a <script> tag into <body> so map loads after page is done loading
      helper.content_for(:javascripts).should include('http://maps.google.com/maps/api/js?sensor=false')
      helper.content_for(:javascript_ready).should include('load_google_map()')
    end
    
    
  end

end
