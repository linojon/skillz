class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery
  
  # Example controller helper:
  
  # helper_method :my_buildings
  # 
  # def my_buildings
  #   if admin?
  #     Building.all 
  #   else
  #     current_user.buildings
  #   end
  # end
  
end
