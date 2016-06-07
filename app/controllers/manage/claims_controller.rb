class Manage::ClaimsController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_claim, only: [:show, :destroy, :accept, :reject, :rollback]

  def index
    @claims = Claim.ordered
  end

  def show
  end

  def accept
    @claim.accept!
    redirect_to manage_claim_path(@claim), notice: 'Заявка принята'
  end

  def reject
    @claim.reject!
    redirect_to manage_claim_path(@claim), notice: 'Заявка отклонена'
  end

  def rollback
    @claim.rollback!
    redirect_to manage_claim_path(@claim), notice: 'Заявка возвращена в исходное состояние'
  end

  def destroy
    @claim.destroy
    redirect_to manage_claims_path, notice: 'Заявка удалена'
  end

  private

    def set_claim
      @claim = Claim.find(params[:id])
    end

end
