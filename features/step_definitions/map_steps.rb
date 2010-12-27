

Then /^I should see a Google map centered on "([^"]*)" with a bouncing marker$/ do |location| #"
  # spot check for the javascript we expect
  js = %Q^new google.maps.Map^
  page.should have_content(js)
  
  # move this into support/latlngs.rb
  lat, lng = 
    case location
      when '02210'
        [42.3112564, -71.0993499]
      when 'USA'
        [37.09024, -95.712891]
    else
      raise "Can't find mapping from \"#{location}\" to a lat lng.\n" +
          "Now, go and add a mapping in #{__FILE__}"
    end
  js = %Q^"center":new google.maps.LatLng(#{lat}, #{lng})^
  page.should have_content(js)
  js = %Q^new google.maps.Marker({"map":google_map,"position":new google.maps.LatLng(#{lat}, #{lng})^
  page.should have_content(js)
  js = %Q^"animation":google.maps.Animation.BOUNCE^
  page.should have_content(js)
end
