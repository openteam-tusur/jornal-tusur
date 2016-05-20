require 'restclient/components'
require 'rack/cache'

class Manage::UsersController < Manage::ApplicationController

  def search
    search_url = URI.encode("#{Settings['profile.users_url']}?term=#{params[:term]}")

    RestClient.enable Rack::CommonLogger
    RestClient.enable Rack::Cache,
      :metastore => "file:#{Rails.root.join('tmp/rack-cache/meta')}",
      :entitystore => "file:#{Rails.root.join('tmp/rack-cache/body')}",
      :verbose => true

    result = RestClient::Request.execute(
      :method => :get,
      :url => search_url,
      :timeout => nil,
      :headers => {
        :Accept => 'application/json'
      }
    ) do |response, request, result, &block|
      response
    end

    render :json => result rescue {}
  end

end
