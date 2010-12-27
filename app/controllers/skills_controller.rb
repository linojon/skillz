class SkillsController < ApplicationController
  before_filter :signin_required
  
  def index
    #@skills = current_user.skills
  end
end
