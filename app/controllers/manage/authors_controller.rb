class Manage::AuthorsController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_issue, only: [:new, :create, :destroy]
  before_action :set_article, only: [:new, :create, :destroy]

  def new
    @author = Author.new
  end

  def create
    author_normalize_params = author_params.each_with_object({}) { |k, h| h[k.first] = normalize_attribute(k.last) }
    author = Author.find_or_create_by(author_normalize_params.reject{ |k, v| %w[phone email].include?(k) })
    author.update_attributes(author_normalize_params)

    if ArticleAuthor.find_by(article_id: @article.id, author_id: author.id).present?
      flash[:alert] = 'Этот автор уже добавлен к статье'
      render :new and return
    else
      ArticleAuthor.create(article_id: @article.id, author_id: author.id)
    end

    redirect_to manage_issue_article_path(@issue, @article)
  end

  def destroy
    article_author = ArticleAuthor.find_by(article_id: @article.id, author_id: Author.find(params[:id]).id)
    article_author.destroy

    redirect_to manage_issue_article_path(@issue, @article)
  end

  def search
    results = Author.search {
      fulltext params[:q]
      without :id, params[:author_ids] if params[:author_ids]
    }.results

    render json: results.to_json
  end

  private

    def set_issue
      @issue = Issue.find(params[:issue_id])
    end

    def set_article
      @article = Article.find(params[:article_id])
    end

    def author_params
      params.require(:author).permit(:ru_surname, :ru_name, :ru_patronymic, :phone, :email)
    end

    def normalize_attribute(value)
      value.present? ? value.mb_chars.downcase.gsub(/\s+/, '-').split('-').map(&:capitalize).join('-').to_s : value
    end

end
