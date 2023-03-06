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
      params.require(:article).permit(:title, :body, :status)
    end
    def set_article
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error 
      render :new, status: :unprocessable_entity
    end

end
