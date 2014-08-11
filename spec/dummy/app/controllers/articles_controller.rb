class ArticlesController < ApplicationController
  # Filters
  before_filter :authenticate_user!, only: :show

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

    # Track the event
    track_event(current_user, "Listing articles")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    # Track the event
    track_event(current_user, "Listing articles")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end
end
