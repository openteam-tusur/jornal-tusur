class ClaimsController < MainController

  def show
  end

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)

    if verify_recaptcha &&
       @claim.save!
      send_emails_about_new_claim
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

    def send_emails_about_new_claim
      PostmanSender.new({
        subject: I18n.t('claim.new_claim_email_for_admin_header'),
        body: render_to_string(partial: 'claims/new_claim_email_for_admin'),
        emails: [
          Settings['mail.new_claim.to'],
          User.with_permissions('admin').map(&:email)
        ]
      }).send_emails

      PostmanSender.new({
        subject: I18n.t('claim.new_claim_email_for_author_header'),
        body: render_to_string(partial: 'claims/new_claim_email_for_author'),
        emails: @claim.email
      }).send_emails
    end

end
