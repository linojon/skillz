# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
# 
#   <% if logged_in? %>
#     Welcome <%= current_user.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
# 
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
# 
#   before_filter :login_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_user, :signed_in?, :redirect_to_target_or_default, :admin?
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def signed_in?
    current_user
  end
  
  def signin_required
    unless signed_in?
      flash[:notice] = "You must first sign in or sign up before accessing this page"
      store_target_location
      redirect_to signin_url
    end
  end
  
  def not_signin_required
    if signed_in?
      flash[:notice] = "You must be signed out to access this page"
      store_target_location
      redirect_to account_url
    end
  end
  
  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def admin?
    current_user && current_user.admin?
  end
  
  def admin_required
    unless admin?
      flash[:error] = "Access denied. You must be an admin to access this page."
      redirect_to root_path
    end
  end

  private
  
  def store_target_location
    session[:return_to] = request.fullpath
  end
end
