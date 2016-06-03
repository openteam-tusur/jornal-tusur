class ArticlesController < MainController

  def index
    @issue = Issue.find(params[:issue_id])
    raise ActionController::RoutingError.new('Not Found') unless @issue.published?

    @articles = @issue.articles.ordered.includes(:section).includes(:authors)

    if @breadcrumbs.present?
      @breadcrumbs.extend_content.push Hashie::Mash.new({
        external_link: nil,
        path: send("#{I18n.locale}_articles_path", @issue),
        slug: @issue.slug,
        title: @issue.title
      })
    end

    @page.related_pages.en = en_articles_path(@issue)
    @page.related_pages.ru = ru_articles_path(@issue)

  end

  def show
    @issue = Issue.find(params[:issue_id])
    raise ActionController::RoutingError.new('Not Found') unless @issue.published?

    @article = Article.find(params[:id])

    if @breadcrumbs.present?
      @breadcrumbs.extend_content.push Hashie::Mash.new({
        external_link: nil,
        path: send("#{I18n.locale}_articles_path", @issue),
        slug: @issue.slug,
        title: @issue.title
      })
      @breadcrumbs.extend_content.push Hashie::Mash.new({
        external_link: nil,
        path: send("#{I18n.locale}_article_path", @issue, @article),
        slug: @article.slug,
        title: @article.title
      })
    end

    @page.related_pages.en = en_article_path(@issue, @article.slug_en || @article.id)
    @page.related_pages.ru = ru_article_path(@issue, @article.slug_ru || @article.id)

  end

end
