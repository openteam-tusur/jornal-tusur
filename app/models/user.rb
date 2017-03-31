class User

  include AuthClient::User
  include TusurHeader::MenuLinks

  acts_as_auth_client_user

  Permission.available_roles.each do |role|
    define_method("#{role}?") { permissions.map(&:role).include? role }
  end

  def app_name
    'journal'
  end

  def self.with_permissions(role)
    Permission.where(role: role).map(&:user).compact.uniq(&:id)
  end

end
