class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :unlock, :search]
  before_action :find_user_article, only: [:edit, :update, :destroy]
  before_action :find_article, only: [:show, :unlock]

  def index
    @articles = Article.order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)

    authorize @article

    if @article.save
      redirect_to blogs_path(handler: current_user.blog.handler), notice: "文章新增成功"
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @article.comments.order(id: :desc)
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to blogs_path, notice: "文章更新成功"
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to blogs_path, notice: "文章已刪除"
  end

  def unlock
    if @article.pincode == params[:pincode]
      set_unlock_articles(@article.id)
      redirect_to article_path(@article)
    else
      redirect_to article_path(@article), notice: "密碼錯誤"
    end
  end

  def search
    @articles = Article.search(params[:keyword])
  end

  private
  def article_params
    params.require(:article).permit(:title, :content, :pincode, :publish_at, :cover_image)
  end

  def find_user_article
    @article = current_user.articles.find(params[:id])
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def set_unlock_articles(article_id)
    if session[:unlock_articles]
      session[:unlock_articles] << article_id
      session[:unlock_articles].uniq!
    else
      session[:unlock_articles] = [article_id]
    end
  end
end
