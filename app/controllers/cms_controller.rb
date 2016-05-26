class CmsController < ApplicationController

  rescue_from ActionView::MissingTemplate do |exception|
    raise ActionController::RoutingError.new('Not Found')
  end if Rails.env.production?

end
