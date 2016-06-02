class ArticlesController < MainController

  before_action :set_issue

  def index
    @breadcrumbs.extend_content.push Hashie::Mash.new({
      external_link: nil,
      path: request.path,
      slug: @issue.slug,
      title: @issue.title
    })
    issue_slug = params[:issue_slug]
  end

  private

    def set_issue
      @issue = Issue.find(params[:issue_id])
    end

end
