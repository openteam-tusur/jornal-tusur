class IssuesController < MainController

  def index
    @issues = Issue.ordered
  end

end
