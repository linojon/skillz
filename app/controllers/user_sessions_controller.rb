class UserSessionsController < ApplicationController
  before_filter :not_signin_required, :only => [:new, :create]
  before_filter :signin_required, :only => :destroy
  before_filter :not_registered_required, :only => [:password]

  def new
    @user_session = UserSession.new
  end
  
  def create
    
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Signed in successfully."
      # go to dashboard if came from root, else return where you started (e.g avoid double redirect)
      session[:return_to]=='/' ? redirect_to(dashboard_path) : redirect_to_target_or_default( dashboard_path )
    else
      @user = User.find_by_email(params[:user_session][:email])
      if @user && !@user.registered?
        render :action => 'password'
      else
        flash[:notice] = "Email or password was entered incorrectly"
        redirect_to signin_path
      end
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You have been signed out."
    redirect_to "/"
  end

  #---
  # step 2 for unregistered users
  def password
    if @user.update_attributes( params[:user])
      # NOTE could just redirect and make them sign in now, but we're too nice
      @user_session = UserSession.new(:email => @user.email, :password => params[:user][:password])
      if @user_session.save
        flash[:notice] = "You are now signed in."
        redirect_to dashboard_path
      else
        flash[:notice] = "Problem signing you in. Please try again"
        redirect_to signin_path
      end
    else
      render :action => 'password'
    end
  end  
  
  private
  
  def not_registered_required
    if signed_in?
      redirect_to( account_url) && return
    end
    @user = User.find_by_email(params[:user][:email]) #note: its :user not :user_session from password form
    if @user.nil? || @user.registered?
      redirect_to( signin_path ) && return
    end
  end
end
