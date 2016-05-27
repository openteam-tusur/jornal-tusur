class Manage::IssuesController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_issue, only: [:edit, :update, :destroy, :approve, :rollback]

  def index
    @issues = Issue.ordered
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to manage_issue_articles_path(@issue), notice: 'Номер журнала создан'
    else
      render :new
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to manage_issue_articles_path(@issue), notice: 'Номер журнала изменён'
    else
      render :edit
    end
  end

  def destroy
    @issue.destroy
    redirect_to manage_issues_path, notice: 'Номер журнала удалён'
  end

  def approve
    @issue.approve!
    redirect_to manage_issue_articles_path(@issue), notice: 'Номер журнала опубликован'
  end

  def rollback
    @issue.rollback!
    redirect_to manage_issue_articles_path(@issue), notice: 'Номер журнала снят с публикации'
  end

  private

    def set_issue
      @issue = Issue.find(params[:id])
    end

    def issue_params
      params.require(:issue).permit(:year, :number, :through_number, :part, :poster)
    end

end
