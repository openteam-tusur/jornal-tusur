require 'active_support/concern'
require 'restclient/components'
require 'rack/cache'

module Cmsable

  extend ActiveSupport::Concern

  included do
    before_action :detect_robots_in_development if Rails.env.development?
    before_action :load_cms_data
  end

  private

  def load_cms_data
    render :file => "#{Rails.root}/public/404", :formats => [:html], :layout => false, :status => 404 and return if request_status == 404

    page_regions.each do |region|
      eval "@#{region} = page.regions.#{region}"
    end

    @site_title = @site_name.try(:content).try(:body) || 'ТУСУР'
    @page_title = page.title
    @navigation_title = page.navigation_title
    @page_meta = page.meta
    @link_to_json = remote_url

    render "templates/#{page.template}"
  end

  def detect_robots_in_development
    puts "\n\n"
    puts "DEBUG ---> #{request.user_agent.to_s}"
    puts "Current locale: #{I18n.locale}"
    puts "Params: #{params}"
    puts "\n\n"

    render :nothing => true, status: :forbidden and return if request.user_agent.to_s.match(/\(.*https?:\/\/.*\)/)
  end

  def remote_url
    raise 'Override me'
  end

  def cms_address
    @cms_address ||= "#{Settings['cms.url']}/nodes/#{Settings['cms.site_slug']}"
  end

  def rest_request
    RestClient.enable Rack::CommonLogger
    RestClient.enable Rack::Cache,
      :metastore => "file:#{Rails.root.join('tmp/rack-cache/meta')}",
      :entitystore => "file:#{Rails.root.join('tmp/rack-cache/body')}",
      :verbose => true

    @rest_request ||= RestClient::Request.execute(
      :method => :get,
      :url => remote_url,
      :timeout => nil,
      :headers => {
        :Accept => 'application/json'
      }
    ) do |response, request, result, &block|
      response
    end
  end

  def request_status
    @request_status ||= rest_request.code
  end

  def request_body
    @request_body ||= rest_request.body
  end

  def page_regions
    @page_regions ||= page.regions.keys
  end

  def page
    @page ||= Hashie::Mash.new(request_json).page
  end

  def request_json
    @request_json ||= begin
                        JSON.load request_body
                      rescue
                        raise 'Response is not a JSON'
                      end
  end

end
