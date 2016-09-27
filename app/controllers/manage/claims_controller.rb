class Manage::ClaimsController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_claim, except: [:index]

  def index
    @claims = Claim.ordered.page(params[:page])
  end

  def update
    if @claim.update!(claim_params)
      redirect_to manage_claim_path(@claim), notice: 'Заявка изменена'
    else
      render [:manage, :edit]
    end
  end

  def accept
    @claim.accept!
    send_email_about_accepted_claim
    redirect_to manage_claim_path(@claim), notice: 'Заявка принята'
  end

  def reject
    @claim.reject!
    send_email_about_rejected_claim
    redirect_to manage_claim_path(@claim), notice: 'Заявка отклонена'
  end

  def rollback
    @claim.rollback!
    send_email_about_rollback_claim
    redirect_to manage_claim_path(@claim), notice: 'Заявка возвращена в исходное состояние'
  end

  def destroy
    @claim.destroy
    redirect_to manage_claims_path, notice: 'Заявка удалена'
  end

  private

  def claim_params
    params.require(:claim).permit(
      :issue_id,
    )
  end

  def set_claim
    @claim = Claim.find(params[:id])
  end

  def send_email_about_accepted_claim
    PostmanSender.new({
      subject: I18n.t('claim.email_about_accepted_header'),
      body: render_to_string(partial: 'claims/email_about_accepted'),
      emails: @claim.email
    }).send_emails
  end

  def send_email_about_rejected_claim
    PostmanSender.new({
      subject: I18n.t('claim.email_about_rejected_header'),
      body: render_to_string(partial: 'claims/email_about_rejected'),
      emails: @claim.email
    }).send_emails
  end

  def send_email_about_rollback_claim
    PostmanSender.new({
      subject: I18n.t('claim.email_about_rollback_header'),
      body: render_to_string(partial: 'claims/email_about_rollback'),
      emails: @claim.email
    }).send_emails
  end

end
