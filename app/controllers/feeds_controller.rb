class FeedsController < ApplicationController
  def index
    @feeds = Feed.all  #controllarにわたされる
    @items = Item.includes(:feed).order('posted_at desc').page(params[:page])
  end

  def new
    @feed = Feed.new
    @feeds = Feed.all
  end

  def create
    @feed = Feed.new(params[:feed])
# models/feed.rbにうつした
#    feed = Feedzirra::Feed.fetch_and_parse(params[:feed][:url])
#    @feed.title = feed.title

    if @feed.save
      redirect_to feeds_path  #saveが成功したらindexへ
    else
      render :new  #失敗したらnew入力へ
    end
  end

  def show
    @feed = Feed.find(params[:id])
    @items = @feed.items
    @feeds = Feed.all
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    @feed = Feed.find(params[:id]) 
    @feed.attributes = params[:feed]
      if @feed.save
        redirect_to feeds_path
      else
        render :edit
      end
  end

  def destroy
    @feed = Feed.destroy(params[:id])
    redirect_to feeds_path
  end

end
