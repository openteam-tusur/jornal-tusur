class User

  include AuthClient::User
  include TusurHeader::MenuLinks

  def app_name
    Settings['app.name']
  end

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      available_permissions.include? role
    end
  end

  def available_permissions
    @available_permissions ||= permissions.pluck(:role)
  end

end
