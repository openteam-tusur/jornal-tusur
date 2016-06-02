class Manage::ApplicationController < ApplicationController

  layout 'manage'

  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to root_path, alert: 'Недостаточно прав для выполнения операции'
    else
      redirect_to sign_in_url, alert: 'Для доступа необходимо войти в систему'
    end
  end

  private

    def set_locale
      I18n.locale = :ru
    end

end
