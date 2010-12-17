class UserSessionsController < ApplicationController
  before_filter :not_signin_required, :only => [:new, :create]
  before_filter :signin_required, :only => :destroy

  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Signed in successfully."
      redirect_to_target_or_default( dashboard_path )
    else
      flash[:notice] = "Email or password was entered incorrectly"
      redirect_to signin_path
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You have been signed out."
    redirect_to "/"
  end
end
