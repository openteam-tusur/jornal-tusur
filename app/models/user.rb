class User
  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name']
  end
end
