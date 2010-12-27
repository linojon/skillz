include Geokit::Geocoders

class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :openid_identifier, :zipcode, :lat, :lng, :metrocode
  
  validates_presence_of :email
  #validates_format_of :email, 
  validates_presence_of :zipcode
  validates_format_of :zipcode, :with => /(^\d{5}$)|(^\d{5}-\d{4}$)/, :message => 'is an invalid zip code' 
  validate :zipcode, :geocode_the_zipcode
  
  acts_as_authentic do |config|
    # gradual engagement
    config.merge_validates_length_of_password_field_options :on => :update
  end
  
  acts_as_mappable
  
  
  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    Notifier.deliver_password_reset_instructions(self)  
  end  
  
  def geocode_the_zipcode
    return if lat.present? && lng.present?
    res = MultiGeocoder.geocode( zipcode )
    if res.success
      self.lat = res.lat
      self.lng = res.lng
      # NOTE: if we need more of the geocode stuff (see the user_spec.rb) maybe should just store this whole object in user
      #       and/or add a Zipcode model that caches the result
      # TODO also get the metrocode
    else
      errors.add(:zipcode, 'is not a valid US zip code')
    end
  end
  
  def registered?
    crypted_password.present?
  end
end
