class Manage::ArticlesController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_issue
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.where(issue: @issue).order(:page_from)
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
      redirect_to manage_issue_article_path(@issue, @article), notice: 'Статья создана'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to manage_issue_article_path(@issue, @article), notice: 'Статья изменена'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to manage_issue_articles_path(@issue), notice: 'Статья удалена'
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
        :issue_id, :ru_title, :en_title, :ru_annotation, :en_annotation,
        :ru_keyword_list, :en_keyword_list, :page_from, :page_to, :file
      )
    end

end
