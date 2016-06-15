class IssuesController < MainController

  def index
    @issues = Issue.published.ordered
    @year_range = {
      min: Issue.ordered.min_by(&:year).year,
      max: @issues.min_by(&:year).year
    }
  end

end
