class CmsController < ApplicationController

  before_filter :set_last_issue

  rescue_from ActionView::MissingTemplate do |exception|
    raise ActionController::RoutingError.new('Not Found')
  end if Rails.env.production?

  private

    def set_last_issue
      @last_issue = Issue.published.ordered.first
    end

end
