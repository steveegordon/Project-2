class UsersController < ApplicationController
  # only allows a logged in user to view edit update and destroy users
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    # verifies users matches the object they are trying to edit
    before_action :correct_user,   only: [:edit, :update, :destroy]
  # shows the specific user as well as all of their posts
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 5)
  end
  # search function designed to allow multiple keys, implemented with single search key at present
  # shows all users unless search implemented then only shows search result
  def index
    if params[:query] && params[:search]
      search_by = params[:search].to_sym
      query = params[:query]
      @users = User.where(search_by => query).paginate(page: params[:page], per_page: 5)
    else
      @users = User.paginate(page: params[:page], per_page: 5)
    end
  end
  # new user page defines user
  def new
    @user = User.new
  end
  # create function run on click creates user and verifies with flash message and redirects to user page
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Newsfeed!"
      redirect_to @user
      # re renders create page if failed
    else
      render 'new'
    end
  end
  # edit page which defines the user to be edited
  def edit
    @user = User.find(params[:id])
  end
  # updates specified user flashes success and redirects back to users page
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      # re-render edit page if update fails
    else
      render 'edit'
    end
  end
# destroys user and flashes success on root url
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end

  private
  # define the user params for update and create function
  def user_params
   params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation, :picture)
  end
# correct users makes sure that a user matches the page being edited or redirects to root
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

end
