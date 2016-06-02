class IssuesController < MainController

  def index
    @issues = Issue.published.ordered
  end

end
