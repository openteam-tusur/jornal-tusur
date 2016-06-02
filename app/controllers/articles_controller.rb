class ArticlesController < MainController

  def index
    @issue = Issue.find(params[:issue_id])
    raise ActionController::RoutingError.new('Not Found') unless @issue.published?

    @articles = @issue.articles

    if @breadcrumbs.present?
      @breadcrumbs.extend_content.push Hashie::Mash.new({
        external_link: nil,
        path: request.path,
        slug: @issue.slug,
        title: @issue.title
      })
    end
  end

end
