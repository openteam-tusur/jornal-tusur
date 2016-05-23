class Manage::ArticlesController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_issue
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.where(issue: @issue)
  end

  def show
  end

  def new
    @article = Article.new(issue: @issue)
  end

  def edit
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to manage_issue_article_path(@issue, @article), notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to manage_issue_article_path(@issue, @article), notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to manage_issue_articles_path(@issue), notice: 'Article was successfully destroyed.'
  end

  private

    def set_issue
      @issue = Issue.find(params[:issue_id])
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(
        :issue_id, :title_ru, :title_en, :annotation_ru, :annotation_en,
        :page_from, :page_to, :file
      )
    end

end
