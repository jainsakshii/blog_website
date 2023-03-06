class CommentsController < ApplicationController
  http_basic_authenticate_with name: "sakshi jain", password: "secret123", only: :destroy
  before_action :get_details, only: [:index]

  def index
    @comment = @article.comments
  end
  def show 
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private
  def get_details
    @id = params[:id]
    @article = Article.find(params[:id])
    @name = Article.find(@id).title
  end
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end
end
