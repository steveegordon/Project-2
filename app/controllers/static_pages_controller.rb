class StaticPagesController < ApplicationController
  # home page if a user session exists populates with a feed including self and follows
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
    end
  end
# static help page
  def help
  end
# static about page
  def about
  end
# static contact page
  def contact
  end

end
