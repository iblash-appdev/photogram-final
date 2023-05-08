class ApplicationController < ActionController::Base
  before_action(:load_current_user)

  # Uncomment line 5 in this file and line 3 in UserAuthenticationController if you want to force users to sign in before any other actions.
  # before_action(:force_user_sign_in)

  def load_current_user
    the_id = session[:user_id]

    @current_user = User.where({ :id => the_id }).first
  end

  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })




    render({ :template => "users/index.html.erb" })
  end

  def show


    the_username = params.fetch("path_username")

    matching_users = User.where({ :username => the_username })

    @the_user = matching_users.at(0)


    matching_follow_requests = FollowRequest.all

    @list_of_follow_requests = matching_follow_requests.order({ :created_at => :desc })

    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    else
    render({ :template => "users/show.html.erb" })
    end
  end

  def liked_photos
    @photos = @current_user.photos

    render({ :template => "users/liked_photos.html.erb" })
  end

  def feed


    render({ :template => "users/feed.html.erb" })
  end

  def discover


    render({ :template => "users/discover.html.erb" })
  end


end
