class User

  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name']
  end

  def self.with_permissions(role)
    Permission.where(role: role).map(&:user).compact.uniq(&:id)
  end

end
