class UsersController < ApplicationController
  #before_filter :signin_required, :except => [:new, :create]
  before_filter :signin_required, :only => [:edit, :update]
  before_filter :admin_required, :only => [:index, :destroy, :toggle_admin]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      if admin?
        flash[:notice] = "User successfully added"
        redirect_to users_path
      else
        UserMailer.welcome_email(@user).deliver
        flash[:notice] = "Thank you for signing up! You are now signed in."
        redirect_to_target_or_default dashboard_url
      end
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated."
      redirect_to account_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    user = User.find params[:id]
    if user==current_user
      flash[:error] = "You cannot delete yourself"
    else
      user.destroy
      flash[:notice] = "User deleted"
    end
    redirect_to users_path    
  end
  
  def toggle_admin
    user = User.find(params[:id])
    user.admin = (user.admin? ? false : true)
    user.save
    flash[:notice] = user.admin? ? "USER IS AN ADMIN" : "User is not an admin"
    redirect_to users_path
  end
end
