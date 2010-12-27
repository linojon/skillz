class PagesController < ApplicationController
  def home
    if signed_in?
      flash.keep
      redirect_to dashboard_path 
    end
  end
  
  def dashboard
    unless signed_in?
      flash.keep
      redirect_to root_path
    end
    redirect_to skills_path #for now
  end
end
