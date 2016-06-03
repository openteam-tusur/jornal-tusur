class ClaimsController < MainController

  def show
  end

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new(claim_params)

    if @claim.save
      redirect_to send("#{I18n.locale}_claim_sended_path"), notice: I18n.t('claim.sended')
    else
      render :new
    end
  end

  private

    def claim_params
      params.require(:claim).permit(:surname, :name, :patronymic, :phone, :email, :address, :workplace, :file)
    end

end
