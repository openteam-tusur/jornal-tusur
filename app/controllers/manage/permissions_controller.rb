class Manage::PermissionsController < Manage::ApplicationController

  def index
    @permissions = Permission.all
  end

  def new
    @permission = Permission.new
  end

  def create
    @permission = Permission.new(permission_params)
    if @permission.save
      redirect_to manage_permissions_path
    else
      render :new
    end
  end

  def destroy
    Permission.find(params[:id]).destroy
    redirect_to manage_permissions_path
  end

  private

  def permission_params
    params.require(:permission).permit(:number, :user_id, :role)
  end

end
