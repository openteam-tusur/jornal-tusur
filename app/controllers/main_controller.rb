class MainController < CmsController

  include Cmsable

  private

  def remote_url
    origin_request_path, parts_params = request.fullpath.split('?')
    request_path = origin_request_path

    request_path = '/ru/arhiv' if origin_request_path.match(/\A\/ru\/arhiv.*/)
    request_path = '/en/archive' if origin_request_path.match(/\A\/en\/archive.*/)

    ["#{cms_address}#{request_path.gsub('//', '/').split('/').compact.join('/')}.json", parts_params].compact.join('?')
  end

end
