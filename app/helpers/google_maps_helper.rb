require 'string' #my String class extensions

module GoogleMapsHelper
  # Presently assume one map per page (named google_map)
  # delayed code is cached in @google_map_scripts
  # must call delay_load_google_map last
  
  # options
  #   :lat      => (required),
  #   :lng      => (required),
  #   :zooom    => 8,
  #   :canvas   => 'map_canvas'
  #   :map_type => nil for google ROADMAP #or 'skillz'
  #   :max_zoom => 12  #set to '' to disable
  #
  def google_map_render( options={} )
    unless options[:lat] && options[:lng]
      # full US map
      options[:lat], options[:lng] = us_center
      options[:zoom] = 2
    end
    map_options = {
      :zoom              => options[:zoom] || 8,
      :center            => "%new google.maps.LatLng(#{options[:lat]}, #{options[:lng]})%",
      :mapTypeId         => options[:map_type] || "%google.maps.MapTypeId.ROADMAP%",
      :disableDefaultUI  => true,
      :mapTypeControl    => false,       # eg street, satellite, etc
      :navigationControl => true,        # zoom buttons
      :scaleControl      => false,       #this is a view only shows feet per inch
    };
    if options[:pan_zoom]==false
      map_options.merge!(
        :disableDoubleClickZoom => true,
        :draggable              => false,
        :navigationControl      => false,
      )
    end
    max_zoom = options[:max_zoom] || 12

    
    canvas = options[:map_canvas] || 'map_canvas'
    
    # initialize the scripts cache
    @google_map_scripts = %Q^
    var mapOptions = #{map_options.to_json.with_js};
    google_map     = new google.maps.Map(document.getElementById("#{canvas}"), mapOptions);
    ^
    
    # set custom type
    google_map_type(options[:map_type])
    
    # max zoom
    if !max_zoom.blank?
      @google_map_scripts << %Q^
      google.maps.event.addListener(google_map, 'zoom_changed', function(){ 
        if (google_map.getZoom() > #{max_zoom}) { google_map.setZoom(#{max_zoom}); } 
      }); 
      ^
    end
    
    nil
  end
  
  #--
  # dont need to call directly, called from google_map_render
  def google_map_type( map_type )
    return unless map_type=='skillz' # the only custom style right now
    skillz_styles = [
      {
        :featureType => :all,
        :stylers     => [ {:hue => "#0000ff"}, {:saturation => -75} ]
      },
      {
        :featureType => :poi,
        :elementType => :label,
        :stylers     => [ {:visibility => :off} ]
      }
    ]
    @google_map_scripts << %Q^
    var stylez = #{skillz_styles.to_json.with_js};
    var styledMapType = new google.maps.StyledMapType(stylez, {name: "#{map_type}"} );
    google_map.mapTypes.set("#{map_type}", styledMapType);
    ^
    
    nil
  end
  
  #---
  # options:
  #   :lat
  #   :lng
  #   :animation =>  'bounce' #versus 'drop'
  #   :title     => 'You'
  #   :icon      => 'flag1.png'
  def google_map_marker( options={} )
    unless options[:lat] && options[:lng]
      # full US map
      options[:lat], options[:lng] = us_center
    end
    marker_options = {
      :map      => "%google_map%",
      :position => "%new google.maps.LatLng(#{options[:lat]}, #{options[:lng]})%",
      :title    => options[:title] || 'You',
      :icon     => '/images/' + (options[:icon] || 'flag1.png'),
      :animation => "%google.maps.Animation.BOUNCE%"
    }
    @google_map_scripts << %Q^
    var map_marker = new google.maps.Marker(#{marker_options.to_json.with_js})
    ^
    
    nil
  end
  
  #--
  # insert scripts into dom to load google map after page is loaded
  def google_map_delay_load
    content_for :javascripts do
      %Q^
      var google_map;
      
      function initialize_google_map(){
        #{@google_map_scripts}
      }
      function load_google_map() {
        var script     = document.createElement("script");
        script.type    = "text/javascript";
        script.src     = "http://maps.google.com/maps/api/js?sensor=false&callback=initialize_google_map";
        document.body.appendChild(script);
      }      
      ^.html_safe
    end
    
    content_for :javascript_ready do
      %Q^
      load_google_map();
      ^.html_safe
    end
    
    nil
  end
  
  private
  
  def us_center
    [37.09024, -95.712891]
  end

end
