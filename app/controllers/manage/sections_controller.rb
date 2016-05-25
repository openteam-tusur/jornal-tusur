class Manage::SectionsController < Manage::ApplicationController

  load_and_authorize_resource

  before_action :set_section, only: [:edit, :update, :destroy]

  def index
    @sections = Section.ordered
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to manage_sections_path, notice: 'Секция создана'
    else
      render :new
    end
  end

  def update
    if @section.update(section_params)
      redirect_to manage_sections_path, notice: 'Секция изменена'
    else
      render :edit
    end
  end

  def destroy
    @section.destroy
    redirect_to manage_sections_path, notice: 'Секция удалена'
  end

  private
    def set_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:ru_title, :en_title)
    end
end
