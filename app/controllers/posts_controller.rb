class PostsController < ApplicationController
  # calls method which checks for login and only allows logged in users to create destroy posts
    before_action :logged_in_user, only: [:create, :destroy]
# creates post belonging to current user
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # one time message on redirect that post was created
      flash[:success] = "Post created"
      redirect_to root_url
    else
      # re-renders home page and does not add item to feed if fails
      @feed_items = []
      render 'static_pages/home'
    end
  end

  private
# defined the params required for post creation
  def post_params
    params.require(:post).permit(:content)
  end
  
end
