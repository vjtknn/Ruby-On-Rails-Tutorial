class StaticPagesController < ApplicationController

  def home
    if logged_in?
      if params[:tag]
        @micropost = current_user.microposts.build
        @feed_items = current_user.feed.paginate(page: params[:page]).tagged_with(params[:tag])
      else
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  end

  def help
  end

  def about
  end

  def contact
  end
end
