class Permission < ActiveRecord::Base

  include AuthClient::Permission

  acts_as_auth_client_permission roles: [:admin, :manager]

   validates_uniqueness_of :role, :scope => :user_id,
    :message => 'У пользователя не может быть несколько одинаковых ролей'

end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  user_id      :string
#  context_id   :integer
#  context_type :string
#  role         :string
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  by_user_and_role_and_context  (user_id,role,context_id,context_type)
#
