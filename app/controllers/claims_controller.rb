class ClaimsController < MainController

  def show
  end

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)

    if verify_recaptcha && @claim.save
      send_claim
      redirect_to send("#{I18n.locale}_claim_sended_path"), notice: I18n.t('claim.sended')
    else
      render :new
    end
  end

  private

    def claim_params
      params.require(:claim).permit(
        :user_id,
        :surname,
        :name,
        :patronymic,
        :phone,
        :email,
        :address,
        :workplace,
        :file
      )
    end

    def send_claim
      Postman::Client::Dispatcher.new(host: Settings['postman.url']).send_mail(
        subject: I18n.t('claim.new_claim_email_header'),
        body: mail_body.to_str,
        # see http://stackoverflow.com/questions/9469825/why-uri-escape-fails-when-called-on-actionviewoutputbuffer
        emails: [
          Settings['mail.new_claim.to'],
          User.with_permissions('admin').map(&:email)
        ].flatten.delete_if(&:blank?).uniq,
        slug: Settings['postman.slug']
      )
    end

    def mail_body
      render_to_string(partial: 'claims/new_claim_email')
    end

end
