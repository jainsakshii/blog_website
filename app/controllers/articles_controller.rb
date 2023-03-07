class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "sakshi jain", password: "secret123", except: [:index, :show]
  before_action :set_article, only: [:edit,:update,:show,:destroy]
  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
    @article.comments.build
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update 
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, comments_attributes: [:commenter, :body])
    end
    def set_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      render plain: "Article id " + params[:id] + " doesn't exist."
      #render file: "#{Rails.root}/public/404.html"
    end
  end
